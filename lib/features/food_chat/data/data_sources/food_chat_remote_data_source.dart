import 'package:google_generative_ai/google_generative_ai.dart';

abstract class FoodChatRemoteDataSource {
  Future<String> getFoodSuggestion(String prompt);
}

class FoodChatRemoteDataSourceImpl implements FoodChatRemoteDataSource {
  final GenerativeModel _model;

  FoodChatRemoteDataSourceImpl(this._model);

  @override
Future<String> getFoodSuggestion(String prompt) async {
  final foodPrompt = """
  You are a friendly and knowledgeable food expert. Respond warmly and informatively based on the user's message.

  - If the user greets you (e.g., "hi", "hello"), greet them back and ask if they need a food suggestion.
  - If they ask for a meal suggestion, recommend a delicious dish with simple preparation steps.
  - If they mention dietary preferences (e.g., vegetarian, keto), suggest a meal that fits their needs.
  - If they ask about a specific ingredient, recommend a dish that includes it.
  - If the message is **not food-related**, politely encourage them to ask about food.

  **User Message:** "$prompt"
  """;

  final response = await _model.generateContent([Content.text(foodPrompt)]);
  return response.text ?? "I couldn't generate a response. Please try again.";
}

}
