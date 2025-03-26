import 'package:dartz/dartz.dart';
import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';
import 'package:prepai/features/Meals/domain/repositories/meal_repository.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import '../../../../Core/errors/failures.dart';

class GetMeals {
  final MealRepository repository;

  GetMeals(this.repository);

  Future<Either<Failure, List<Meal>>> call() {
    return repository.getUserMeals();
  }
}