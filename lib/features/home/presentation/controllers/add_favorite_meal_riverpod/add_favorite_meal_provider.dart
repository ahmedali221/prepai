import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/di/dep_inj.dart';
import 'package:prepai/features/home/domain/use_cases/add_favorite_meal_use_case.dart';
import 'package:prepai/features/home/presentation/controllers/add_favorite_meal_riverpod/add_favorite_meal_notifier.dart';
import 'package:prepai/features/home/presentation/controllers/add_favorite_meal_riverpod/add_favorite_meal_state.dart';

final addFavoriteMealProvider =
    StateNotifierProvider<AddFavoriteMealNotifier, AddFavoriteMealState>((ref) {
  final addFavoriteMealsUseCase = getIt<AddFavoriteMealsUseCase>();
  return AddFavoriteMealNotifier(addFavoriteMealsUseCase);
});
