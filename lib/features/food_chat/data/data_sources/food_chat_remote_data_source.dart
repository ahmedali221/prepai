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
You are an AI food assistant. Your job is to provide **detailed** meal recommendations in a human-readable text format.

### **Response Format (Strictly Follow This):**
Meal Name: [Write the meal name]  
Summary: [A short, enticing description of the meal]  

### **Ingredients:**  
- Ingredient 1  
- Ingredient 2  
- Ingredient 3  

### **Steps to Prepare:**  
1. Step 1: [Describe the first step]  
2. Step 2: [Describe the second step]  
3. Step 3: [Describe the third step]  

### **Nutritional Information:**  
- Calories: X kcal  
- Protein: X g  
- Fat: X g  
- Carbohydrates: X g  

### **Preparation Time:** X minutes  

**Important Rules:**  
- Do **NOT** return only the meal name.  
- Do **NOT** use JSON or markdown.  
- The response **must** be **detailed and formatted** exactly as shown.  

**User Request:** "$prompt"  

Now, provide a **full, structured response**.  
""";

    final response = await _model.generateContent([Content.text(foodPrompt)]);

    return response.text ?? "Sorry, I couldn't generate a response.";
  }
}
