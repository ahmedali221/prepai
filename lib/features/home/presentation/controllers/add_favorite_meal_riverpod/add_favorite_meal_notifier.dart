import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/home/domain/entities/mealEntity.dart';
import 'package:prepai/features/home/domain/use_cases/add_favorite_meal_use_case.dart';
import 'package:prepai/features/home/presentation/controllers/add_favorite_meal_riverpod/add_favorite_meal_state.dart';

class AddFavoriteMealNotifier extends StateNotifier<AddFavoriteMealState> {
  final AddFavoriteMealsUseCase addFavoriteMealsUseCase;
  AddFavoriteMealNotifier(this.addFavoriteMealsUseCase)
      : super(AddFavoriteMealState.initial());
  Future<void> addFavoriteMeal(MealEntity meal) async {
    state = AddFavoriteMealState.loading();
    final result = await addFavoriteMealsUseCase.call(meal);
    result.fold(
      (failure) {
        print("[AddFavoriteMealNotifier] Add Favorite Meal Failed: $failure");
        state = AddFavoriteMealState.error(failure.toString());
      },
      (_) {
        print("[AddFavoriteMealNotifier] Meal added successfully");
        state = AddFavoriteMealState.authenticated();
      },
    );
  }
}
