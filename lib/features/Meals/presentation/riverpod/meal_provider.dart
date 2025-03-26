import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';
import 'meal_notifier.dart';
import 'get_meals_provider.dart';

final mealProvider = StateNotifierProvider<MealNotifier, AsyncValue<List<Meal>>>((ref) {
  final getMeals = ref.watch(getMealsProvider);
  return MealNotifier(getMeals);
});