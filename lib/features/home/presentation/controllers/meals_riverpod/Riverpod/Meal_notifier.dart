import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/domain/use_cases/mealsUseCases.dart';
import 'package:prepai/features/home/presentation/controllers/meals_riverpod/Riverpod/Meal_State.dart';

class MealNotifier extends StateNotifier<MealState> {
  final GetMealsUseCase mealsUseCase;

  MealNotifier(this.mealsUseCase) : super(MealState.initial());

  Future<void> fetchData(
      {int? mealPreparationTime, String? mealName, String? mealType}) async {
    state = MealState.loading();
    final result = await mealsUseCase.call(
        mealPreparationTime: mealPreparationTime,
        mealName: mealName,
        mealType: mealType);

    result.fold(
      (failure) {
        print("[MealNotifier] Fetch Meals Failed: $failure");
        state = MealState.error(failure.toString());
      },
      (meals) {
        print("[MealNotifier] Meals fetched successfully: ${meals.length}");
        state = MealState.authenticated(Right(meals));
      },
    );
  }
}
