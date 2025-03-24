import 'package:prepai/features/Auth/data/models/user_model.dart';

enum MealStatus { initial, loading, authenticated, error }

class AuthState {
  final MealStatus status;
  final UserModel? user;
  final String? errorMessage;

  AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  // Initial state
  factory AuthState.initial() => AuthState(status: MealStatus.initial);

  // Loading state
  factory AuthState.loading() => AuthState(status: MealStatus.loading);

  // Authenticated state
  factory AuthState.authenticated(UserModel user) =>
      AuthState(status: MealStatus.authenticated, user: user);

  // Error state
  factory AuthState.error(String message) =>
      AuthState(status: MealStatus.error, errorMessage: message);
}
