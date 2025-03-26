import 'package:dartz/dartz.dart';
import 'package:prepai/features/Meals/data/models/mealsModel.dart';

enum MealStatus { initial, loading, authenticated, error }

class MealState {
  final MealStatus status;
  final Either<String, List<MealModel>>? Meal;
  final String? errorMessage;

  MealState({
    required this.status,
    this.Meal,
    this.errorMessage,
  });

  // Initial state
  factory MealState.initial() => MealState(status: MealStatus.initial);

  // Loading state
  factory MealState.loading() => MealState(status: MealStatus.loading);

  // Authenticated state
  factory MealState.authenticated(Either<String, List<MealModel>> meal) =>
      MealState(status: MealStatus.authenticated, Meal: meal);

  // Error state
  factory MealState.error(String message) =>
      MealState(status: MealStatus.error, errorMessage: message);
}
