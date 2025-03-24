// features/meal/data/repositories/meal_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';

import '../../domain/entities/mealEntity.dart';
import '../../domain/repos/mealRepo.dart';
import '../data_source/meal_remote_dataSource.dart';
import '../models/mealsModel.dart';

class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource remoteDataSource;

  MealRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<FirebaseFailure, List<MealEntity>>> getMeals() async {
    print('[MealRepositoryImpl] Fetching meals...');
    final result = await remoteDataSource.getMeals();

    return result.fold(
      (failure) {
        print('[MealRepositoryImpl] Error: ${failure.errorMessage}');
        return Left(failure);
      },
      (models) {
        final entities = models.map((model) => model.toEntity()).toList();
        print('[MealRepositoryImpl] Converted ${entities.length} meals');
        return Right(entities);
      },
    );
  }

  @override
  Future<Either<FirebaseFailure, void>> addMeal(MealEntity meal) async {
    print('[MealRepositoryImpl] Adding meal: ${meal.name}');
    final mealModel = MealModel.fromEntity(meal);
    final result = await remoteDataSource.addMeal(mealModel);

    return result.fold(
      (failure) {
        print('[MealRepositoryImpl] Error: ${failure.errorMessage}');
        return Left(failure);
      },
      (_) {
        print('[MealRepositoryImpl] Meal added successfully');
        return const Right(null);
      },
    );
  }
}
