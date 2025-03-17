import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prepai/features/Auth/data/data%20source/auth_remote_data_source.dart';
import 'package:prepai/features/Auth/domain/models/user_model.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';
import 'package:prepai/utils/validators.dart'; 

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
      return Left(_mapFirebaseError(e));
    } catch (e) {
      return Left("An unexpected error occurred. Please try again later.");
    }
  }

  // 3. Handle Firebase errors
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return "This email is already in use.";
      case 'invalid-email':
        return "Invalid email format.";
      case 'weak-password':
        return "Password must be at least 8 characters.";
      default:
        return "Authentication failed. Please try again.";
    }
  }
}
