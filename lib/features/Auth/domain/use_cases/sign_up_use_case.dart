import 'package:dartz/dartz.dart';
import 'package:prepai/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:prepai/features/Auth/domain/models/user_model.dart';

class SignUpUseCase {
  final AuthRepositoryImpl repository;

  SignUpUseCase(this.repository);
  Future<Either<String, UserModel>> call(String name, String email, String password, String phone) {
    return repository.signUp(name, email, password, phone);
  }
}
