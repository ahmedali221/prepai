import 'package:dartz/dartz.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';
import 'package:prepai/features/Auth/data/models/user_model.dart';

class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase(this.authRepository);

  Future<Either<String, UserModel>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    return authRepository.signUp(name, email, password, phone);
  }

  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) {
    return authRepository.login(email, password);
  }

  Future<void> logout() async {
    await authRepository.logout();
  }
}
