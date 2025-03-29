import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';
import 'package:prepai/features/Meals/presentation/riverpod/get_meals_provider.dart';
import 'meal_notifier.dart';


final mealProvider = StateNotifierProvider<MealNotifier, AsyncValue<List<Meal>>>((ref) {
  final getMeals = ref.watch(getMealsProvider);
  return MealNotifier(getMeals);
});


final mealFavoriteProvider = StateNotifierProvider.family<MealFavoriteNotifier, bool, Meal>(
      (ref, meal) => MealFavoriteNotifier(meal.isFav),
);

final mealDetailProvider = Provider.family<Meal, String>((ref, mealId) {
  final meals = ref.watch(mealProvider);
  return meals.when(
    data: (list) => list.firstWhere((meal) => meal.id == mealId, orElse: () => Meal.empty()),
    loading: () => Meal.empty(),
    error: (_, __) => Meal.empty(),
  );
});