import 'package:prepai/features/auth/data/models/user_model.dart';

enum AuthStatus { initial, loading, authenticated, error }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;

  AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  // Initial state
  factory AuthState.initial() => AuthState(status: AuthStatus.initial);

  // Loading state
  factory AuthState.loading() => AuthState(status: AuthStatus.loading);

  // Authenticated state
  factory AuthState.authenticated(UserModel user) =>
      AuthState(status: AuthStatus.authenticated, user: user);

  // Error state
  factory AuthState.error(String message) =>
      AuthState(status: AuthStatus.error, errorMessage: message);
}
