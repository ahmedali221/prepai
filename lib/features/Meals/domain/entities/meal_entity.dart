  class Meal {
    final String id;
    final String name;
    final String subtitle;
    final Duration duration;
    final int servings;
    final String summary;
    final Nutrition nutrition;
    final List<Ingredient> ingredients;
    final List<String> steps;
    final String image;
    final bool isFav;

    const Meal({
      required this.id,
      required this.name,
      required this.subtitle,
      required this.image,
      required this.duration,
      required this.servings,
      required this.summary,
      required this.ingredients,
      required this.steps,
      required this.nutrition,
      this.isFav = false,
    });
  }

  class Nutrition {
    final double protein;
    final double carbs;
    final double fat;
    final double kcal;
    final double vitamins;

    const Nutrition({
      required this.protein,
      required this.carbs,
      required this.fat,
      required this.kcal,
      required this.vitamins,
    });
  }

  class Ingredient {
    final String name;
    final int quantity;

    const Ingredient({
      required this.name,
      required this.quantity,
    });
  }