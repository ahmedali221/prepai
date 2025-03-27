import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:prepai/core/services/firebase_service.dart';
import 'package:prepai/features/Auth/data/data%20source/auth_remote_data_source.dart';
import 'package:prepai/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';
import 'package:prepai/features/Auth/domain/use_cases/auh_use_case.dart';
import 'package:prepai/features/food_chat/data/data_sources/food_chat_remote_data_source.dart';
import 'package:prepai/features/food_chat/data/repositories/food_chat_repository.dart';
import 'package:prepai/features/food_chat/domain/repositories/food_chat_repository.dart';
import 'package:prepai/features/food_chat/domain/use_cases/get_food_suggestion.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<FirebaseService>()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(getIt<AuthRepository>()),
  );

// 🔹 Register Google Generative AI Model
  getIt.registerLazySingleton<GenerativeModel>(
    () => GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: dotenv.env['GEMINI_API_KEY']!,
      generationConfig: GenerationConfig(
        maxOutputTokens: 200,
        temperature: 0.5,
      ),
    ),
  );

  // 🔹 Register Food Chat Dependencies
  getIt.registerLazySingleton<FoodChatRemoteDataSource>(
    () => FoodChatRemoteDataSourceImpl(getIt<GenerativeModel>()),
  );
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  getIt.registerLazySingleton<FoodChatRepository>(
    () => FoodChatRepositoryImpl(
        getIt<FoodChatRemoteDataSource>(), getIt<FirebaseFirestore>()),
  );

  getIt.registerLazySingleton<GetFoodSuggestion>(
    () => GetFoodSuggestion(getIt<FoodChatRepository>()),
  );
}
