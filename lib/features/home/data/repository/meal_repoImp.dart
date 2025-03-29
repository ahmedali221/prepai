// features/meal/data/repositories/meal_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/home/data/datasources/remote_data_sources/meal_remote_dataSource.dart';
import '../../domain/entities/mealEntity.dart';
import '../../domain/repository/mealRepo.dart';

import '../models/mealsModel.dart';

class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource remoteDataSource;

  MealRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<FirebaseFailure, List<MealEntity>>> getMeals(
      {int? mealPreparationTime, String? mealName, String? mealType}) async {
    print('[MealRepositoryImpl] Fetching meals...');
    final result = await remoteDataSource.fetchUserMeals(
        mealPreparationTime: mealPreparationTime,
        mealName: mealName,
        mealType: mealType);

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
