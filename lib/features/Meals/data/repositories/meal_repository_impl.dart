import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prepai/Core/services/firebase_service.dart';
import 'package:prepai/features/Meals/data/models/meal_model.dart';
import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/Meals/domain/repositories/meal_repository.dart';
import '../../../../Core/errors/failures.dart';

class MealRepositoryImpl implements MealRepository {
  final FirebaseService firebaseService; // Inject FirebaseService

  final FirebaseFirestore firestore;
  final storage = FlutterSecureStorage();

  MealRepositoryImpl(this.firebaseService, {required this.firestore});

  @override
  Future<Either<Failure, List<Meal>>> getUserMeals() async {
    final Either<FirebaseFailure, List<Map<String, dynamic>>> result =
    await firebaseService.fetchUserMeals();

    return result.fold(
          (failure) => Left(FirebaseFailure(failure.errorMessage)),
          (mealsList) {
        List<Meal> meals = mealsList.map((mealJson) {
          try {
            return MealModel.fromMap(mealJson);
          } catch (e) {
            return MealModel(
              mealId: '',
              name: 'Error',
              time: 'N/A',
              servings: 0,
              ingredients: [],
              steps: [],
              nutrition: {},
              image: '',
            ); // Default value if parsing fails
          }
        }).toList();
        return Right(meals);
      },
    );
  }
}