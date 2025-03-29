class Meal {
  final String id;
  final String name;
  final String summary;
  final List<String> ingredients;
  final List<String> steps;
  final String mealType;
  final String preparationTime;
  final Map<String, String> nutrition; // Key: nutrient, Value: amount
  final DateTime createdAt;

  Meal({
    required this.id,
    required this.name,
    required this.summary,
    required this.ingredients,
    required this.steps,
    required this.mealType,
    required this.preparationTime,
    required this.nutrition,
    required this.createdAt,
  });

  // Convert to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'summary': summary,
      'ingredients': ingredients,
      'steps': steps,
      'mealType': mealType,
      'preparationTime': preparationTime,
      'nutrition': nutrition, // Map is stored as a sub-document
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert from Firestore Map
  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      summary: map['summary'] ?? '',
      ingredients: List<String>.from(map['ingredients'] ?? []),
      steps: List<String>.from(map['steps'] ?? []),
      mealType: map['mealType'] ?? 'unknown',
      preparationTime: map['preparationTime'] ?? 'Unknown',
      nutrition: Map<String, String>.from(map['nutrition'] ?? {}),
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
