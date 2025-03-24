import '../repositories/food_chat_repository.dart';

class GetFoodSuggestion {
  final FoodChatRepository repository;

  GetFoodSuggestion(this.repository);

  Future<String> call(String prompt) async {
    return await repository.getFoodSuggestion(prompt);
  }
}