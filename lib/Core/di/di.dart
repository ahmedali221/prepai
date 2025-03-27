import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prepai/features/Meals/data/data_source/meal_remote_dataSource.dart';
import 'package:prepai/features/Meals/data/repository/meal_repoImp.dart';
import 'package:prepai/features/Meals/domain/repos/mealRepo.dart';
import 'package:prepai/features/Meals/domain/use_cases/mealsUseCases.dart';
import 'package:prepai/features/home/data/datasources/remote_data_sources/user_profile_remote_data_source.dart';
import 'package:prepai/features/home/data/repository/user_data_repo.dart';
import 'package:prepai/features/home/domain/repository/base_user_data_repo.dart';
import 'package:prepai/features/home/domain/use_cases/change_password_use_case.dart';
import 'package:prepai/features/home/domain/use_cases/fetch_password_use_case.dart';
import 'package:prepai/features/home/domain/use_cases/fetch_user_data_use_case.dart';
import 'package:prepai/features/home/domain/use_cases/post_user_data_use_case.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Core Services
  getIt.registerLazySingleton<UserProfileRemoteDataSourceImp>(
    () => UserProfileRemoteDataSourceImp(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ),
  );

  // // Data Sources
  // getIt.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(getIt<FirebaseService>()),
  // );

  // // Repository
  // getIt.registerLazySingleton<AuthRepository>(
  //   () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  // );

  // // Use Cases
  // getIt.registerLazySingleton<AuthUseCase>(
  //   () => AuthUseCase(getIt<AuthRepository>()),
  // );

  // User data repo
  getIt.registerLazySingleton<BaseUserDataRepo>(
    () => UserDataRepo(
        userProfileRemoteDataSourceImp:
            getIt<UserProfileRemoteDataSourceImp>()),
  );

  // User data use case
  getIt.registerLazySingleton<FetchUserDataUseCase>(
    () => FetchUserDataUseCase(baseUserDataRepo: getIt<BaseUserDataRepo>()),
  );

  getIt.registerLazySingleton<PostUserDataUseCase>(
    () => PostUserDataUseCase(baseUserDataRepo: getIt<BaseUserDataRepo>()),
  );

  getIt.registerLazySingleton<FetchPasswordUseCase>(
    () => FetchPasswordUseCase(baseUserDataRepo: getIt<BaseUserDataRepo>()),
  );

  getIt.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(baseUserDataRepo: getIt<BaseUserDataRepo>()),
  );
  /////////////////////////////////////////GET MEALS////////////////////////////////////
  getIt.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(getIt<MealRemoteDataSource>()),
  );

  getIt.registerLazySingleton<MealRemoteDataSource>(
    () => MealRemoteDataSource(
      FlutterSecureStorage(),
      FirebaseFirestore.instance,
    ),
  );

  getIt.registerLazySingleton<GetMealsUseCase>(
    () => GetMealsUseCase(getIt()),
  );
}
