import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';
import 'package:prepai/features/Meals/domain/usecases/meal_usecase.dart';
import 'package:prepai/features/Meals/presentation/riverpod/get_meals_provider.dart';

class MealNotifier extends StateNotifier<AsyncValue<List<Meal>>> {
  final GetMeals _getMeals;

  MealNotifier(this._getMeals) : super(const AsyncValue.loading()){
    fetchMeals();
  }

  Future<void> fetchMeals() async {
    state = const AsyncValue.loading();
    final result = await _getMeals();
    state = result.fold(
          (failure) => AsyncValue.error(failure, StackTrace.current),
          (meals) => AsyncValue.data(meals),
    );
  }
}

class MealFavoriteNotifier extends StateNotifier<bool> {
  MealFavoriteNotifier(bool isFav) : super(isFav);

  void toggleFavorite() {
    state = !state; // Toggle favorite state
  }
}