import 'package:firebase_auth/firebase_auth.dart';
import 'package:prepai/core/errors/firebase_errors.dart';
import 'package:prepai/core/services/firebase_service.dart';
import 'package:prepai/features/Auth/domain/entities/user_entity.dart';


abstract class AuthRemoteDataSource {
  Future<UserEntity?> signUp(
      String name, String email, String password, String phone);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseService _firebaseService;

  AuthRemoteDataSourceImpl(this._firebaseService);

  @override
  Future<UserEntity?> signUp(
      String name, String email, String password, String phone) async {
    try {
      final credential = await _firebaseService.firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw FirebaseFailure("User creation failed. Please try again.");
      }

      final user = UserEntity(
        uid: firebaseUser.uid,
        name: name,
        email: email,
        phone: phone,
      );

      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseFailure.fromAuthError(e);
    } on FirebaseException catch (e) {
      throw FirebaseFailure.fromFirestoreError(e);
    } catch (e) {
      throw FirebaseFailure("An unexpected error occurred during sign-up.");
    }
  }
}
