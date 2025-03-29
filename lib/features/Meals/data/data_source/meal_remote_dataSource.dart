// features/meal/data/datasources/meal_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/Core/utils/firebase_constants.dart';
import '../models/mealsModel.dart';

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

      // Apply filters dynamically
      if (mealName != null) {
        query = query
            .where('meal_name', isGreaterThanOrEqualTo: mealName)
            .where('meal_name', isLessThanOrEqualTo: '$mealName\uf8ff');
      }
      if (mealType != null) {
        query = query.where('meal_type', isEqualTo: mealType);
        print('Applied filter: meal_type = $mealType');
      }
      if (mealPreparationTime != null) {
        query = query.where('meal_preparation_time',
            isEqualTo: mealPreparationTime);
        print('Applied filter: meal_preparation_time = $mealPreparationTime');
      }

      // Execute the query once
      QuerySnapshot<Map<String, dynamic>> mealsSnapshot = await query.get();
      print('Query Result: ${mealsSnapshot.docs.length} docs found');
      if (mealsSnapshot.docs.isEmpty) {
        return Left(FirebaseFailure('No meals found for this user.'));
      }

      List<MealModel> mealsList = mealsSnapshot.docs
          .map((doc) => MealModel.fromJson(doc.data()))
          .toList();

      print('Returning ${mealsList.length} meals');
      return Right(mealsList);
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      print('Exception: $e');
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
          print('[MealRemoteDataSource] Meal added successfully');
          return const Right(null);
        },
      );
    } catch (e) {
      print('[MealRemoteDataSource] Error: $e');
      return Left(FirebaseFailure('Failed to add meal: $e'));
    }
  }
}
