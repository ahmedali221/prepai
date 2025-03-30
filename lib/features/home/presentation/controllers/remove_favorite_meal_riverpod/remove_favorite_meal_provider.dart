import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/di/dep_inj.dart';
import 'package:prepai/features/home/domain/use_cases/remove_favorite_meal_use_case.dart';
import 'package:prepai/features/home/presentation/controllers/remove_favorite_meal_riverpod/remove_favorite_meal_notifier.dart';
import 'package:prepai/features/home/presentation/controllers/remove_favorite_meal_riverpod/remove_favorite_meal_state.dart';

final removeFavoriteMealProvider =
    StateNotifierProvider<RemoveFavoriteMealNotifier, RemoveFavoriteMealState>(
        (ref) {
  final removeFavoriteMealUseCase = getIt<RemoveFavoriteMealsUseCase>();

  return RemoveFavoriteMealNotifier(removeFavoriteMealUseCase);
});
