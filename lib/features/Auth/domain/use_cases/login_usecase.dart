import 'package:prepai/features/Auth/data/repositories/auth_repository.dart';
import 'package:prepai/features/Auth/domain/entities/user_entity.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<UserEntity?> execute(String email, String password) async {

    final userModel = await authRepository.login(email, password);

    if (userModel != null) {
      final userEntity = UserEntity(email: userModel.email, uid: userModel.uid, name: userModel.name);
      return userEntity;
    }
    return null;
  }
}