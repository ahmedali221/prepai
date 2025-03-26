// features/meal/data/datasources/meal_remote_data_source.dart
import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/Core/services/firebase_service.dart';
import '../models/mealsModel.dart';

abstract class MealRemoteDataSource {
  Future<Either<FirebaseFailure, List<MealModel>>> getMeals();
  Future<Either<FirebaseFailure, void>> addMeal(MealModel meal);
}

class MealRemoteDataSourceimp implements MealRemoteDataSource {
  final FirebaseService firebaseService;
  MealRemoteDataSourceimp(this.firebaseService);

  Future<Either<FirebaseFailure, List<MealModel>>> getMeals() async {
    try {
      print('[MealRemoteDataSource] Fetching meals...');
      final result = await firebaseService.fetchUserMeals();

      return result.fold(
        (failure) => Left(failure),
        (mealsList) {
          final meals = mealsList.map((mealData) {
            print(
                '[MealRemoteDataSource] Processing meal: ${mealData['mealId']}');
            return MealModel.fromJson(mealData);
          }).toList();
          print('[MealRemoteDataSource] Retrieved ${meals.length} meals');
          return Right(meals);
        },
      );
    } catch (e) {
      print('[MealRemoteDataSource] Error: $e');
      return Left(FirebaseFailure('Failed to fetch meals: $e'));
    }
  }

  Future<Either<FirebaseFailure, void>> addMeal(MealModel meal) async {
    try {
      final result = await firebaseService.addNewMeal(mealData: meal.toJson());
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
