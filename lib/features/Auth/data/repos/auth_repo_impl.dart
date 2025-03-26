import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/Core/utils/validators.dart';
import 'package:prepai/features/Auth/data/data%20source/auth_remote_data_source.dart';
import 'package:prepai/features/Auth/data/models/user_model.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';


class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, UserModel>> signUp(
      String name, String email, String password, String phone) async {
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
      return Left(FirebaseFailure.fromAuthError(e).errorMessage);
    } catch (e) {
      return Left("An unexpected error occurred. Please try again later.");
    }
  }

  @override
  Future<Either<String, UserModel>> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return const Left("Email and password are required.");
    }
    if (!Validators.isValidEmail(email)) {
      return const Left("Invalid email format.");
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        return Right(UserModel(
          uid: user.uid,
          email: user.email ?? "",
          name: user.displayName ?? "",
          phone: '',
        ));
      } else {
        return const Left('User not found');
      }
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromAuthError(e).errorMessage);
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }
}
