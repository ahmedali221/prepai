import '../../domain/entities/mealEntity.dart';

class MealModel {
  final String mealName;
  final int mealPreparationTime;
  final String mealTextSummary;
  final MealNutritionModel mealNutritions;
  final Map<String, int> mealIngredients;
  final Map<String, String> mealSteps;

  const MealModel({
    required this.mealName,
    required this.mealPreparationTime,
    required this.mealTextSummary,
    required this.mealNutritions,
    required this.mealIngredients,
    required this.mealSteps,
  });

  // JSON Serialization
  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      mealName: json['meal_name'] ?? '',
      mealPreparationTime: json['meal_preparation_time'] ?? 0,
      mealTextSummary: json['meal_text_summary'] ?? '',
      mealNutritions:
          MealNutritionModel.fromJson(json['meal_nutritions'] ?? {}),
      mealIngredients: Map<String, int>.from(json['meal_ingredients'] ?? {}),
      mealSteps: Map<String, String>.from(json['meal_steps'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meal_name': mealName,
      'meal_preparation_time': mealPreparationTime,
      'meal_text_summary': mealTextSummary,
      'meal_nutritions': mealNutritions.toJson(),
      'meal_ingredients': mealIngredients,
      'meal_steps': mealSteps,
    };
  }

  // Entity Conversion
  factory MealModel.fromEntity(MealEntity entity) {
    return MealModel(
      mealName: entity.name,
      mealPreparationTime: entity.preparationTime,
      mealTextSummary: entity.textSummary,
      mealNutritions: MealNutritionModel.fromEntity(entity.nutrition),
      mealIngredients: entity.ingredients,
      mealSteps: entity.steps,
    );
  }

  MealEntity toEntity() {
    return MealEntity(
      name: mealName,
      preparationTime: mealPreparationTime,
      textSummary: mealTextSummary,
      nutrition: mealNutritions.toEntity(),
      ingredients: mealIngredients,
      steps: mealSteps,
    );
  }
}

class MealNutritionModel {
  final int protein;
  final int carbs;
  final int fat;
  final int kcal;
  final int vitamins;

  const MealNutritionModel({
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.kcal,
    required this.vitamins,
  });

  // JSON Serialization
  factory MealNutritionModel.fromJson(Map<String, dynamic> json) {
    return MealNutritionModel(
      protein: json['protein'] ?? 0,
      carbs: json['carbs'] ?? 0,
      fat: json['fat'] ?? 0,
      kcal: json['kcal'] ?? 0,
      vitamins: json['vitamins'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'kcal': kcal,
      'vitamins': vitamins,
    };
  }

  // Entity Conversion
  factory MealNutritionModel.fromEntity(MealNutritionEntity entity) {
    return MealNutritionModel(
      protein: entity.protein,
      carbs: entity.carbs,
      fat: entity.fat,
      kcal: entity.kcal,
      vitamins: entity.vitamins,
    );
  }

  MealNutritionEntity toEntity() {
    return MealNutritionEntity(
      protein: protein,
      carbs: carbs,
      fat: fat,
      kcal: kcal,
      vitamins: vitamins,
    );
  }
}
