import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prepai/Core/utils/firebase_constants.dart';
import 'package:prepai/features/Meals/data/models/meal_model.dart';
import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/Meals/domain/repositories/meal_repository.dart';
import '../../../../Core/errors/failures.dart';

class MealRepositoryImpl implements MealRepository {
  final FirebaseFirestore firestore;
  final storage = FlutterSecureStorage();

  MealRepositoryImpl({required this.firestore});

  @override
  Future<Either<Failure, List<Meal>>> getUserMeals() async {
    try {
      // Retrieve user ID from secure storage
      final userId = await storage.read(key: "userId");
      if (userId == null) {
        return Left(FirebaseFailure('User ID not found in secure storage.'));
      }

      // Fetch meals from Firestore
      QuerySnapshot<Map<String, dynamic>> mealsSnapshot = await firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersMealsCollectionName)
          .get();

      if (mealsSnapshot.docs.isEmpty) {
        return Left(FirebaseFailure('No meals found for this user.'));
      }

      // Convert Firestore documents into MealModel objects
      List<Meal> meals = mealsSnapshot.docs.map((doc) {
        try {
          return MealModel.fromMap({"mealId": doc.id, ...doc.data()});
        } catch (e) {
          return MealModel(
            id: '',
            name: 'Error',
            duration: const Duration(minutes: 0),
            servings: 0,
            summary: '',
            ingredients: [],
            steps: {},
            nutrition: const NutritionModel(protein: 0, carbs: 0, fat: 0, kcal: 0, vitamins: 0),
            image: '',
            subtitle: '',
          ); // Default value if parsing fails
        }
      }).toList();

      return Right(meals);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }
}