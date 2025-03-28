import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';


class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase(this.authRepository);

  Future<Either<FirebaseFailure, String>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    return authRepository.signUp(name, email, password, phone);
  }

  Future<Either<FirebaseFailure, String>> login({
    required String email,
    required String password,
  }) {
    return authRepository.login(email, password);
  }

  Future<void> logout() async {
    await authRepository.logout();
  }
}
