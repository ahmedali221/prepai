import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/Auth/domain/use_cases/auh_use_case.dart';
import 'package:prepai/features/Auth/presentation/providers/auth_state.dart';


class AuthNotifier extends StateNotifier<AuthState> {
  final AuthUseCase authUseCase;

  AuthNotifier(this.authUseCase) : super(AuthState.initial());

  Future<Either<FirebaseFailure, String>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    state = AuthState.loading();

    final result = await authUseCase.signUp(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );

    result.fold(
      (error) => state = AuthState.error(error.errorMessage),
      (message) => state = AuthState.error(message),
    );

    return result;
  }

  Future<Either<FirebaseFailure, String>> login({
    required String email,
    required String password,
  }) async {
    state = AuthState.loading();

    final result = await authUseCase.login(email: email, password: password);

    result.fold(
      (error) => state = AuthState.error(error.errorMessage),
      (message) => state = AuthState.error(message),
    );

    return result;
  }

  Future<void> logout() async {
    await authUseCase.logout();
    state = AuthState.initial();
  }
}
