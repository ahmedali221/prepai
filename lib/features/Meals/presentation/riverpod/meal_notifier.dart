import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';
import 'package:prepai/features/Meals/domain/usecases/meal_usecase.dart';

class MealNotifier extends StateNotifier<AsyncValue<List<Meal>>> {
  final GetMeals getMeals;

  MealNotifier(this.getMeals) : super(const AsyncValue.loading());

  Future<void> fetchMeals() async {
    state = const AsyncValue.loading();
    final result = await getMeals();
    result.fold(
          (failure) => state = AsyncValue.error(failure, StackTrace.current),
          (meals) => state = AsyncValue.data(meals),
    );
  }
}