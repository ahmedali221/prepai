import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';

class MealModel extends Meal {
  const MealModel({
    required super.id,
    required super.name,
    required super.subtitle,
    required super.image,
    required super.duration,
    required super.servings,
    required super.summary,
    required super.ingredients,
    required super.steps,
    required super.nutrition,
    super.isFav,
  });

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Unknown',
      subtitle: map['subtitle'] as String? ?? '',
      image: map['image'] as String? ?? '',
      duration: Duration(minutes: (map['duration'] as int?) ?? 0),
      servings: map['servings'] as int? ?? 0,
      summary: map['summary'] as String? ?? '',
      ingredients: (map['ingredients'] as List<dynamic>?)
          ?.map((item) => IngredientModel.fromMap(item as Map<String, dynamic>))
          .toList() ??
          [],
      steps: (map['steps'] as List<dynamic>?)
          ?.map((step) => step.toString())
          .toList() ??
          [],
      nutrition: NutritionModel.fromMap(map['nutrition'] as Map<String, dynamic>? ?? {}),
      isFav: map['isFav'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'image': image,
      'duration': duration.inMinutes,
      'servings': servings,
      'summary': summary,
      'ingredients': ingredients.map((ingredient) => (ingredient as IngredientModel).toMap()).toList(),
      'steps': steps,
      'nutrition': (nutrition as NutritionModel).toMap(),
      'isFav': isFav,
    };
  }
}

class IngredientModel extends Ingredient {
  const IngredientModel({required super.name, required super.quantity});

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      name: map['name'] as String? ?? 'Unknown',
      quantity: map['quantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}

class NutritionModel extends Nutrition {
  const NutritionModel({
    required super.protein,
    required super.carbs,
    required super.fat,
    required super.kcal,
    required super.vitamins,
  });

  factory NutritionModel.fromMap(Map<String, dynamic> map) {
    return NutritionModel(
      protein: (map['protein'] as num?)?.toDouble() ?? 0.0,
      carbs: (map['carbs'] as num?)?.toDouble() ?? 0.0,
      fat: (map['fat'] as num?)?.toDouble() ?? 0.0,
      kcal: (map['kcal'] as num?)?.toDouble() ?? 0.0,
      vitamins: (map['vitamins'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'kcal': kcal,
      'vitamins': vitamins,
    };
  }
}