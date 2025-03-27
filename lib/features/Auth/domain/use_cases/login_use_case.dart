import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<Either<FirebaseFailure, String>> execute(
      String email, String password) async {
    final result = await authRepository.login(email, password);

    return result;
  }
}
