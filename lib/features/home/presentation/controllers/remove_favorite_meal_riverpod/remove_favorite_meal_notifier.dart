import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/home/domain/use_cases/remove_favorite_meal_use_case.dart';

import 'package:prepai/features/home/presentation/controllers/meals_riverpod/Riverpod/Meal_State.dart';
import 'package:prepai/features/home/presentation/controllers/remove_favorite_meal_riverpod/remove_favorite_meal_state.dart';

class RemoveFavoriteMealNotifier
    extends StateNotifier<RemoveFavoriteMealState> {
  final RemoveFavoriteMealsUseCase removeFavoritemealsUseCase;

  RemoveFavoriteMealNotifier(this.removeFavoritemealsUseCase)
      : super(RemoveFavoriteMealState.initial());

  Future<void> removeFavoriteMeal({required String mealId}) async {
    state = RemoveFavoriteMealState.loading();
    final result = await removeFavoritemealsUseCase.call(
      mealID: mealId,
    );

    result.fold(
      (failure) {
        state = RemoveFavoriteMealState.error(failure.toString());
      },
      (message) {
        state = RemoveFavoriteMealState.loaded(Right(message));
      },
    );
  }
}
