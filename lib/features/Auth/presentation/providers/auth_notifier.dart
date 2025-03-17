import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Auth/domain/models/user_model.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';
import 'package:prepai/features/Auth/presentation/providers/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier(this.authRepository) : super(AuthState.initial());

  Future<void> signUp(
      String name, String email, String password, String phone) async {
    state = AuthState.loading();

    final result = await authRepository.signUp(name, email, password, phone);

    result.fold(
      (error) => state = AuthState.error(error),
      (user) => state = AuthState.authenticated(user),
    );
  }

 Future<Either<String, UserModel>> login({required String email, required String password}) async {
  state = AuthState.loading();

  final result = await authRepository.login(email, password);

  result.fold(
    (error) => state = AuthState.error(error),
    (user) => state = AuthState.authenticated(user),
  );

  return result;
}

}
