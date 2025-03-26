import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/core/di/di.dart';
import 'package:prepai/features/Meals/domain/use_cases/mealsUseCases.dart';
import 'package:prepai/features/Meals/presentation/Riverpod/Meal_State.dart';
import 'package:prepai/features/Meals/presentation/Riverpod/Meal_notifier.dart';

final mealProvider = StateNotifierProvider<MealNotifier, MealState>((ref) {
  final mealUseCase = getIt<GetMealsUseCase>();
  return MealNotifier(mealUseCase);
});
