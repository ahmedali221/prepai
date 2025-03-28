import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/Auth/data/repos/auth_repo_impl.dart';

class SignUpUseCase {
  final AuthRepositoryImpl repository;

  SignUpUseCase(this.repository);
  Future<Either<FirebaseFailure, String>> call(
      String name, String email, String password, String phone) {
    return repository.signUp(name, email, password, phone);
  }
}
