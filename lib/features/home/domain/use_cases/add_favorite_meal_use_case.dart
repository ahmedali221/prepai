import 'package:dartz/dartz.dart';
import 'package:prepai/features/home/domain/repository/mealRepo.dart';
import '../../../../Core/errors/firebase_errors.dart';
import '../entities/mealEntity.dart';

class AddFavoriteMealsUseCase {
  final MealRepository repository;

  AddFavoriteMealsUseCase(this.repository);

  Future<Either<FirebaseFailure, void>> call(MealEntity meal) async {
    final result = await repository.addFavoriteMeal(meal);
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (_) {
        return Right(_);
      },
    );
  }
}
