import 'package:prepai/features/Auth/data/models/user_model.dart';

enum MealStatus { initial, loading, authenticated, error }

class MealState {
  final MealStatus status;
  final UserModel? user;
  final String? errorMessage;

  MealState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  // Initial state
  factory MealState.initial() => MealState(status: MealStatus.initial);

  // Loading state
  factory MealState.loading() => MealState(status: MealStatus.loading);

  // Authenticated state
  factory MealState.authenticated(UserModel user) =>
      MealState(status: MealStatus.authenticated, user: user);

  // Error state
  factory MealState.error(String message) =>
      MealState(status: MealStatus.error, errorMessage: message);
}
