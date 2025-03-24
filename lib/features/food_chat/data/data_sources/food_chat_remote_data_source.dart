import 'package:google_generative_ai/google_generative_ai.dart';

abstract class FoodChatRemoteDataSource {
  Future<String> getFoodSuggestion(String prompt);
}

class FoodChatRemoteDataSourceImpl implements FoodChatRemoteDataSource {
  final GenerativeModel _model;

  FoodChatRemoteDataSourceImpl()
      : _model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: 'AIzaSyD8x_YZDptH-Ti3uOfs4REidI5rWinTEEE',
          generationConfig: GenerationConfig(
            maxOutputTokens: 200,
            temperature: 0.5,
          ),
        );

  @override
  Future<String> getFoodSuggestion(String prompt) async {
    // Ensure prompt is food-related
    final foodPrompt = "Only answer if this is about food, cooking, recipes, or nutrition. "
        "If not, respond with 'Please ask about food-related topics only.' "
        "Here's the question: $prompt";
    
    final response = await _model.generateContent([Content.text(foodPrompt)]);
    return response.text ?? "I couldn't generate a response. Please try again.";
  }
}