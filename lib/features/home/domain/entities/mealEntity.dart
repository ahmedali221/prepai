class MealEntity {
  final String name;
  final int preparationTime;
  final String textSummary;
  final MealNutritionEntity nutrition;
  final Map<String, int> ingredients;
  final Map<String, String> steps;

  const MealEntity({
    required this.name,
    required this.preparationTime,
    required this.textSummary,
    required this.nutrition,
    required this.ingredients,
    required this.steps,
  });
}

class MealNutritionEntity {
  final int protein;
  final int carbs;
  final int fat;
  final int kcal;
  final int vitamins;

  const MealNutritionEntity({
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.kcal,
    required this.vitamins,
  });
}
