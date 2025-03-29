import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:prepai/features/food_chat/data/data_sources/food_chat_remote_data_source.dart';
import 'package:prepai/features/food_chat/data/models/meal_model.dart';
import 'package:prepai/features/food_chat/domain/repositories/food_chat_repository.dart';
import 'package:uuid/uuid.dart';

class FoodChatRepositoryImpl implements FoodChatRepository {
  final FoodChatRemoteDataSource remoteDataSource;
  final FirebaseFirestore firestore;
  final _uuid = const Uuid();

  FoodChatRepositoryImpl(this.remoteDataSource, this.firestore);

  @override
  Future<String> getFoodSuggestion(String prompt, String mealType) async {
    final responseText = await remoteDataSource.getFoodSuggestion(prompt);

    if (responseText.isEmpty || responseText.trim().length < 20) {
      return "⚠️ Error: AI response was empty or invalid.";
    }

    final mealData = extractMealData(responseText, mealType);

    if (mealData.name == "Not provided") {
      return "⚠️ Error: Could not parse the AI response correctly.";
    }

    await saveMealToFirestore(mealData);

    return """
**🍽️ Meal Name:** ${mealData.name}

**📌 Summary:** ${mealData.summary}

**⏳ Preparation Time:** ${mealData.preparationTime}

**🛒 Ingredients:**
${mealData.ingredients.join("\n")}

**📝 Steps:**
${mealData.steps.join("\n")}

**📊 Nutrition:**
${mealData.nutrition.entries.map((e) => "${e.key}: ${e.value}").join("\n")}
""";
  }

  Future<void> saveMealToFirestore(Meal meal) async {
    try {
      await firestore.collection('meals').doc(meal.id).set(meal.toMap());
      print("✅ Meal saved to Firestore.");
    } catch (e) {
      print("❌ Error saving meal: $e");
    }
  }

  Meal extractMealData(String responseText, String mealType) {
    try {
      final lines = responseText.split("\n").map((e) => e.trim()).toList();

      String name =
          extractField(lines, ["meal name", "dish name"]) ?? "Not provided";
      String summary =
          extractField(lines, ["summary", "description"]) ?? "Not provided";
      String prepTime =
          extractField(lines, ["preparation time", "prep time"]) ??
              "Not provided";

      List<String> ingredients =
          extractList(lines, ["ingredients", "ingredient list"]);
      List<String> steps = extractList(
          lines, ["steps to prepare", "instructions", "directions"]);
      Map<String, String> nutrition = extractNutrition(lines);

      if (ingredients.isEmpty) ingredients.add("Not provided");
      if (steps.isEmpty) steps.add("Not provided");
      if (nutrition.isEmpty) nutrition["Nutrition Details"] = "Not provided";

      if (kDebugMode) {
        print("✅ Extracted Meal Data:");
        print("  Name: $name");
        print("  Summary: $summary");
        print("  Prep Time: $prepTime");
        print("  Ingredients: $ingredients");
        print("  Steps: $steps");
        print("  Nutrition: $nutrition");
      }

      return Meal(
        id: _uuid.v4(),
        name: name,
        summary: summary,
        ingredients: ingredients,
        steps: steps,
        mealType: mealType,
        preparationTime: prepTime,
        nutrition: nutrition,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      print("❌ Error extracting meal data: $e");
      return Meal(
        id: _uuid.v4(),
        name: "Not provided",
        summary: "Not provided",
        ingredients: ["Not provided"],
        steps: ["Not provided"],
        mealType: mealType,
        preparationTime: "Not provided",
        nutrition: {"Nutrition Details": "Not provided"},
        createdAt: DateTime.now(),
      );
    }
  }

  String? extractField(List<String> lines, List<String> fieldNames) {
    for (String line in lines) {
      for (String field in fieldNames) {
        if (line.toLowerCase().contains(field.toLowerCase())) {
          return line.split(RegExp(r'[:\-]')).skip(1).join().trim();
        }
      }
    }
    return null;
  }

  List<String> extractList(List<String> lines, List<String> sectionNames) {
    List<String> extractedList = [];
    bool isSection = false;

    for (String line in lines) {
      if (sectionNames
          .any((name) => line.toLowerCase().contains(name.toLowerCase()))) {
        isSection = true;
        continue;
      }
      if (isSection) {
        if (line.isEmpty || line.contains(":")) break;
        extractedList.add(line.replaceAll(RegExp(r"^\-|\✔️"), "").trim());
      }
    }
    return extractedList;
  }

  Map<String, String> extractNutrition(List<String> lines) {
    Map<String, String> nutrition = {};

    for (String line in lines) {
      List<String> parts = line.split(":");
      if (parts.length == 2) {
        nutrition[parts[0].trim()] = parts[1].trim();
      }
    }
    return nutrition;
  }
}
