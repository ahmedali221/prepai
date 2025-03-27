import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';

abstract class AuthRepository {
  Future<Either<FirebaseFailure, String>> signUp(String name, String email, String password, String phone);
  
  Future<Either<FirebaseFailure, String>> login(String email, String password);

  Future<void> logout();
}
