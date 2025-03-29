import 'package:dartz/dartz.dart';
import 'package:prepai/features/home/domain/repository/mealRepo.dart';
import '../../../../Core/errors/firebase_errors.dart';
import '../entities/mealEntity.dart';

class GetMealsUseCase {
  final MealRepository repository;

  GetMealsUseCase(this.repository);

  Future<Either<FirebaseFailure, List<MealEntity>>> call(
      {int? mealPreparationTime,
      String? mealName,
      String? mealType,
      bool? isFavorite}) async {
    final result = await repository.getMeals(
        mealPreparationTime: mealPreparationTime,
        mealName: mealName,
        mealType: mealType,
        isFavorite: isFavorite);

    return result.fold(
      (failure) {
        return Left(failure);
      },
      (meals) {
        return Right(meals);
      },
    );
  }
}
