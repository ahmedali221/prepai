import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prepai/features/Auth/data/data%20source/auth_remote_data_source.dart';
import 'package:prepai/features/Auth/domain/models/user_model.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, UserModel>> signUp(
      String name, String email, String password, String phone) async {
    // 🔍 1. Validate input using regex
    if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
      return const Left("All fields are required.");
    }
    if (!isValidEmail(email)) {
      return const Left("Invalid email format.");
    }
    if (!isValidPassword(password)) {
      return const Left(
          "Password must be at least 8 characters long and contain at least one letter and one number.");
    }
    if (!isValidPhone(phone)) {
      return const Left("Invalid phone number format.");
    }

    try {
      // 🔥 2. Call Firebase sign-up method
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
      return Left("An unexpected error occurred: ${e.toString()}");
    }
  }

  // 🛑 3. Handle Firebase errors properly
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return "This email is already in use.";
      case 'invalid-email':
        return "Invalid email format.";
      case 'weak-password':
        return "Password must be at least 8 characters.";
      default:
        return "Authentication failed: ${e.message}";
    }
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return regex.hasMatch(password);
  }

  bool isValidPhone(String phone) {
    final regex = RegExp(r'^\+?[0-9]{10,15}$');
    return regex.hasMatch(phone);
  }
}
