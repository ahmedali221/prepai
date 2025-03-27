import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prepai/features/Auth/data/data%20source/auth_remote_data_source.dart';
import 'package:prepai/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';
import 'package:prepai/features/Auth/domain/use_cases/auh_use_case.dart';

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

  // Auth Remote Data Sources imp
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(getIt<AuthRepository>()),
  );

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
}
