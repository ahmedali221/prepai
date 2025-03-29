// features/meal/data/datasources/meal_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/Core/utils/firebase_constants.dart';
import 'package:prepai/features/home/data/models/mealsModel.dart';

class MealRemoteDataSource {
  final FlutterSecureStorage storage;
  final FirebaseFirestore firestore;

  MealRemoteDataSource(this.storage, this.firestore);

  Future<Either<FirebaseFailure, List<MealModel>>> fetchUserMeals({
    int? mealPreparationTime,
    String? mealName,
    String? mealType,
  }) async {
    try {
      final userId = await storage.read(key: "userId");
      Query<Map<String, dynamic>> query = firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersMealsCollectionName);
      CollectionReference<Map<String, dynamic>> mealsCollection = firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersMealsCollectionName);
      List<Map<String, dynamic>> fixedMeals = [
        {
          "meal_name": "Kofta",
          "meal_nutrations": {
            "carp": 100,
            "fat": 50,
            "kcal": 400,
            "protein": 300,
            "vitamens": 70,
          },
          "meal_preparartion_time": 14,
          "meal_steps": {
            "step_1": "buy bread",
          },
          "meal_text_summary":
              "A flavorful Middle Eastern dish made from minced meat (usually beef or lamb) mixed with herbs, spices, and onions. It's often grilled or baked and served with rice, salad, or tahini sauce.",
          "meals_ingrediants": {
            "bread": 1,
            "meat": 2,
          },
          "is_favourite": false,
          "meal_type": "lunch",
        }
      ];

      DocumentReference<Map<String, dynamic>> docRef =
          mealsCollection.doc(fixedMeals[0]['meal_name']);
      DocumentSnapshot<Map<String, dynamic>> snapshot = await docRef.get();
      if (!snapshot.exists) {
        await docRef.set(fixedMeals[0]);
      }
      if (mealName != null) {
        query = query
            .where('meal_name', isGreaterThanOrEqualTo: mealName)
            .where('meal_name', isLessThanOrEqualTo: '$mealName\uf8ff');
      }
      if (mealType != null) {
        query = query.where('meal_type', isEqualTo: mealType);
      }
      if (mealPreparationTime != null) {
        query = query.where('meal_preparation_time',
            isEqualTo: mealPreparationTime);
      }

      // Execute the query once
      QuerySnapshot<Map<String, dynamic>> mealsSnapshot = await query.get();
      if (mealsSnapshot.docs.isEmpty) {
        return Left(FirebaseFailure('No meals found for this user.'));
      }

      List<MealModel> mealsList = mealsSnapshot.docs
          .map((doc) => MealModel.fromJson(doc.data()))
          .toList();
      print("momo $mealsList");
      return Right(mealsList);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }

  Future<Either<FirebaseFailure, String>> addNewMeal({
    required Map<String, dynamic> mealData,
  }) async {
    try {
      final userId = await storage.read(key: "userId");
      final mealsRef = firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersMealsCollectionName);
      await mealsRef.add(mealData);
      return Right('Meal added successfully!');
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }
/////////////////////////////////////

  Future<Either<FirebaseFailure, void>> addMeal(MealModel meal) async {
    try {
      final result = await addNewMeal(mealData: meal.toJson());
      return result.fold(
        (failure) => Left(failure),
        (_) {
          return const Right(null);
        },
      );
    } catch (e) {
      return Left(FirebaseFailure('Failed to add meal: $e'));
    }
  }
}
