abstract class FoodChatRepository {
  Future<String> getFoodSuggestion(String prompt, String mealType);
}
