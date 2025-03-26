class Meal {
  final String mealId;
  final String name;
  final String image;
  final String time;
  final int servings;
  final List<Map<String, dynamic>> ingredients;
  final List<Map<String, dynamic>> steps;
  final Map<String, dynamic> nutrition;

  const Meal({
    required this.mealId,
    required this.name,
    required this.image,
    required this.time,
    required this.servings,
    required this.ingredients,
    required this.steps,
    required this.nutrition,
  });
}