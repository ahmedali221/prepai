import 'package:dartz/dartz.dart';
import 'package:prepai/features/home/domain/repository/mealRepo.dart';
import '../../../../Core/errors/firebase_errors.dart';
import '../entities/mealEntity.dart';

class RemoveFavoriteMealsUseCase {
  final MealRepository repository;

  RemoveFavoriteMealsUseCase(this.repository);

  Future<Either<FirebaseFailure, void>> call({required String mealID}) async {
    final result = await repository.removeFavoriteMeal(
        mealId: mealID); //addFavoriteMeal(meal);
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (message) {
        return Right(message);
      },
    );
  }
}
