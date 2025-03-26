import 'package:dartz/dartz.dart';
import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import '../../../../Core/errors/failures.dart';

abstract class MealRepository {
  Future<Either<Failure, List<Meal>>> getUserMeals();
}