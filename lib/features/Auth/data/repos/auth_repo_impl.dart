import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prepai/core/errors/firebase_errors.dart';
import 'package:prepai/features/Auth/data/data%20source/auth_remote_data_source.dart';
import 'package:prepai/features/Auth/domain/models/user_model.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';
import 'package:prepai/core/utils/validators.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, UserModel>> signUp(
      String name, String email, String password, String phone) async {
    // 1. Validate input
    if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
      return const Left("All fields are required.");
    }
    if (!Validators.isValidEmail(email)) {
      return const Left("Invalid email format.");
    }
    if (!Validators.isValidPassword(password)) {
      return const Left(
          "Password must be at least 8 characters long and contain at least one letter and one number.");
    }
    if (!Validators.isValidPhone(phone)) {
      return const Left("Invalid phone number format.");
    }

    try {
      // 2. Call Firebase sign-up method
      final user = await remoteDataSource.signUp(name, email, password, phone);
      if (user == null) {
        return const Left("Failed to create user.");
      }

      return Right(UserModel(
        uid: user.uid,
        name: user.name,
        email: user.email,
        phone: user.phone,
      ));
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromAuthError(e).errorMessage); // Use FirebaseFailure
    } catch (e) {
      return Left("An unexpected error occurred. Please try again later.");
    }
  }
}
