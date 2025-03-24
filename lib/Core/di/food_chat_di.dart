import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:prepai/features/food_chat/data/data_sources/food_chat_remote_data_source.dart';
import 'package:prepai/features/food_chat/data/repositories/food_chat_repository_impl.dart';
import 'package:prepai/features/food_chat/domain/repositories/food_chat_repository.dart';
import 'package:prepai/features/food_chat/domain/use_cases/get_food_suggestion.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register Google Generative AI Model
  getIt.registerLazySingleton<GenerativeModel>(() => GenerativeModel(
        model: 'gemini-pro',
        apiKey: 'YOUR_GEMINI_API_KEY', // Replace with your actual API key
        generationConfig: GenerationConfig(
          maxOutputTokens: 200,
          temperature: 0.5,
        ),
      ));

  // Register Data Source
  getIt.registerLazySingleton<FoodChatRemoteDataSource>(
      () => FoodChatRemoteDataSourceImpl(getIt<GenerativeModel>()));

  // Register Repository
  getIt.registerLazySingleton<FoodChatRepository>(
      () => FoodChatRepositoryImpl(getIt<FoodChatRemoteDataSource>()));

  // Register Use Case
  getIt.registerLazySingleton<GetFoodSuggestion>(
      () => GetFoodSuggestion(getIt<FoodChatRepository>()));
}
