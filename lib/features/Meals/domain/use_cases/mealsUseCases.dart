import 'package:dartz/dartz.dart';
import '../../../../Core/errors/firebase_errors.dart';
import '../entities/mealEntity.dart';
import '../repos/mealRepo.dart';

class GetMealsUseCase {
  final MealRepository repository;

  GetMealsUseCase(this.repository);

  Future<Either<FirebaseFailure, List<MealEntity>>> call() async {
    print('[GetMealsUseCase] Executing...');
    final result = await repository.getMeals();

    return result.fold(
      (failure) {
        print('[GetMealsUseCase] Failed: ${failure.errorMessage}');
        return Left(failure);
      },
      (meals) {
        print('[GetMealsUseCase] Retrieved ${meals.length} meals');
        return Right(meals);
      },
    );
  }
}
