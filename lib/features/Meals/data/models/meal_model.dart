import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';

class MealModel extends Meal {
  const MealModel({
    required super.mealId,
    required super.name,
    required super.time,
    required super.servings,
    required super.ingredients,
    required super.steps,
    required super.nutrition,
  });

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      mealId: map['mealId'] as String,
      name: map['name'] as String,
      time: map['time'] as String,
      servings: map['servings'] as int,
      ingredients: List<Map<String, dynamic>>.from(map['ingredients']),
      steps: List<Map<String, dynamic>>.from(map['steps']),
      nutrition: Map<String, dynamic>.from(map['nutrition']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mealId': mealId,
      'name': name,
      'time': time,
      'servings': servings,
      'ingredients': ingredients,
      'steps': steps,
      'nutrition': nutrition,
    };
  }
}