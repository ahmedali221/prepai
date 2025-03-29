import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/di/dep_inj.dart';

import 'package:prepai/features/home/domain/use_cases/mealsUseCases.dart';

import 'package:prepai/features/home/presentation/controllers/meals_riverpod/Riverpod/Meal_State.dart';
import 'package:prepai/features/home/presentation/controllers/meals_riverpod/Riverpod/Meal_notifier.dart';

final mealProvider = StateNotifierProvider<MealNotifier, MealState>((ref) {
  final mealUseCase = getIt<GetMealsUseCase>();
  return MealNotifier(mealUseCase);
});
final isFilteredProvider = StateProvider<bool>((ref) {
  return false;
});
