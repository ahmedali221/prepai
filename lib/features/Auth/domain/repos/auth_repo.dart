import 'package:dartz/dartz.dart';
import '../models/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, UserModel>> signUp(String name, String email, String password, String phone);
}
