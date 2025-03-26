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
    required super.image,
  });

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      mealId: map['mealId'] as String? ?? '',
      name: map['name'] as String? ?? 'Unknown',
      time: map['time'] as String? ?? 'Unknown',
      servings: map['servings'] as int? ?? 0,
      ingredients: (map['ingredients'] as List<dynamic>?)
          ?.map((item) => Map<String, dynamic>.from(item as Map))
          .toList() ??
          [],
      steps: (map['steps'] as List<dynamic>?)
          ?.map((item) => Map<String, dynamic>.from(item as Map))
          .toList() ??
          [],
      nutrition: Map<String, dynamic>.from(map['nutrition'] ?? {}),
      image: map['image'] as String? ?? '',
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
      'image': image,
    };
  }
}