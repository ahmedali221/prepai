import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prepai/Core/services/firebase_service.dart';
import 'package:prepai/features/Auth/data/data%20source/auth_remote_data_source.dart';
import 'package:prepai/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';
import 'package:prepai/features/Meals/data/data_source/meal_remote_dataSource.dart';
import 'package:prepai/features/Meals/data/repository/meal_repoImp.dart';
import 'package:prepai/features/Meals/domain/repos/mealRepo.dart';
import 'package:prepai/features/Meals/domain/use_cases/mealsUseCases.dart';
import 'package:prepai/features/auth/domain/use_cases/auh_use_case.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Core Services
  getIt.registerLazySingleton<FirebaseService>(
    () => FirebaseService(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ),
  );
  getIt.registerLazySingleton<MealRemoteDataSource>(
    () => MealRemoteDataSourceimp(getIt<FirebaseService>()),
  );
  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<FirebaseService>()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(getIt<MealRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetMealsUseCase>(
    () => GetMealsUseCase(getIt<MealRepository>()),
  );
}
