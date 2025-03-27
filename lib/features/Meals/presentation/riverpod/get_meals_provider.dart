import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/domain/usecases/meal_usecase.dart';
import 'meal_repository_provider.dart';

final getMealsProvider = Provider<GetMeals>((ref) {
  final repository = ref.watch(mealRepositoryProvider);
  return GetMeals(repository);
});
