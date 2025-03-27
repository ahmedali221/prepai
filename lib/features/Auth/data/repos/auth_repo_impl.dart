import 'package:dartz/dartz.dart';

import 'package:prepai/Core/errors/firebase_errors.dart';

import 'package:prepai/Core/utils/validators.dart';
import 'package:prepai/features/Auth/data/data%20source/auth_remote_data_source.dart';

import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<FirebaseFailure, String>> signUp(
      String name, String email, String password, String phone) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
      return Left(
          FirebaseFailure.fromValidationError("All fields are required."));
    }
    if (!Validators.isValidEmail(email)) {
      return Left(FirebaseFailure.fromValidationError("Invalid email format."));
    }
    if (!Validators.isValidPassword(password)) {
      return Left(FirebaseFailure.fromValidationError(
          "Password must be at least 8 characters long and contain at least one letter and one number."));
    }
    if (!Validators.isValidPhone(phone)) {
      return Left(
          FirebaseFailure.fromValidationError("Invalid phone number format."));
    }

    return remoteDataSource.signUp(
        email: email, password: password, name: name, phone: phone);
  }

  @override
  Future<Either<FirebaseFailure, String>> login(
      String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return Left(FirebaseFailure.fromValidationError(
          "Email and password are required."));
    }
    if (!Validators.isValidEmail(email)) {
      return Left(FirebaseFailure.fromValidationError("Invalid email format."));
    }

    return remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}
