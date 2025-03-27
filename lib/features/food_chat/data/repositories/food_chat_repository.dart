import 'package:prepai/features/food_chat/data/data_sources/food_chat_remote_data_source.dart';
import '../../domain/repositories/food_chat_repository.dart';

class FoodChatRepositoryImpl implements FoodChatRepository {
  final FoodChatRemoteDataSource remoteDataSource;

  FoodChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> getFoodSuggestion(String prompt) {
    return remoteDataSource.getFoodSuggestion(prompt);
  }
}
