import 'package:dartz/dartz.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, UserModel>> signUp(String name, String email, String password, String phone);
  
  Future<Either<String, UserModel>> login(String email, String password);

  Future<void> logout();
}
