import 'package:dartz/dartz.dart';
import 'package:prepai/features/home/domain/entities/mealEntity.dart';

enum MealStatus { initial, loading, loaded, error }

class MealState {
  final MealStatus status;
  final Either<String, List<MealEntity>>? meals;
  final String? errorMessage;
  final bool isFiltered;
  final int? filteredTime;
  final String? filteredMealType;

  const MealState({
    required this.status,
    this.meals,
    this.errorMessage,
    this.isFiltered = false,
    this.filteredTime,
    this.filteredMealType,
  });

  factory MealState.initial() => const MealState(status: MealStatus.initial);
  factory MealState.loading() => const MealState(status: MealStatus.loading);

  factory MealState.loaded(Either<String, List<MealEntity>> meals) =>
      MealState(status: MealStatus.loaded, meals: meals);

  factory MealState.error(String message) =>
      MealState(status: MealStatus.error, errorMessage: message);

  // Add copyWith for state management
  MealState copyWith({
    MealStatus? status,
    Either<String, List<MealEntity>>? meals,
    String? errorMessage,
    bool? isFiltered,
    int? filteredTime,
    String? filteredMealType,
  }) {
    return MealState(
      status: status ?? this.status,
      meals: meals ?? this.meals,
      errorMessage: errorMessage ?? this.errorMessage,
      isFiltered: isFiltered ?? this.isFiltered,
      filteredTime: filteredTime ?? this.filteredTime,
      filteredMealType: filteredMealType ?? this.filteredMealType,
    );
  }
}
