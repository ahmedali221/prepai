import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import '../entities/mealEntity.dart';

abstract class MealRepository {
  Future<Either<FirebaseFailure, List<MealEntity>>> getMeals();
  Future<Either<FirebaseFailure, void>> addMeal(MealEntity meal);
}
