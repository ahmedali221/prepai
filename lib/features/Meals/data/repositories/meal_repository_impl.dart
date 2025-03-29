import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prepai/Core/utils/firebase_constants.dart';
import 'package:prepai/features/Meals/data/datasources/meal_remote_data_source.dart';
import 'package:prepai/features/Meals/data/models/meal_model.dart';
import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/Meals/domain/repositories/meal_repository.dart';
import '../../../../Core/errors/failures.dart';

class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource remoteDataSource;
  final storage = FlutterSecureStorage();

  MealRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Meal>>> getUserMeals() async {
    try {
      final userId = await storage.read(key: "userId");
      if (userId == null) {
        return Left(FirebaseFailure('User ID not found in secure storage.'));
      }

      final mealsData = await remoteDataSource.getUserMeals(userId);
      if (mealsData.isEmpty) {
        return Left(FirebaseFailure('No meals found for this user.'));
      }

      List<Meal> meals = mealsData.map((map) => MealModel.fromMap(map)).toList();

      return Right(meals);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }
}
