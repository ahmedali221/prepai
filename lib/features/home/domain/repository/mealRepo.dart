import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import '../entities/mealEntity.dart';

abstract class MealRepository {
  Future<Either<FirebaseFailure, List<MealEntity>>> getMeals(
      {int? mealPreparationTime,
      String? mealName,
      String? mealType,
      bool? isFavorite});
  Future<Either<FirebaseFailure, void>> addFavoriteMeal(MealEntity meal);
  Future<Either<FirebaseFailure, void>> removeFavoriteMeal({
    required String mealId,
  });
}
