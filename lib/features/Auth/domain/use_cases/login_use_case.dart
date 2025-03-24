import 'package:dartz/dartz.dart';
import 'package:prepai/features/Auth/domain/entities/user_entity.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<Either<String, UserEntity>> execute(String email, String password) async {
    final result = await authRepository.login(email, password);

    return result.fold(
      (error) => Left(error), 
      (userModel) => Right(UserEntity(
        email: userModel.email,
        uid: userModel.uid,
        name: userModel.name, phone: '',
      )),
    );
  }
}
