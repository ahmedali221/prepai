import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prepai/core/errors/firebase_errors.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity?> signUp(
      String name, String email, String password, String phone);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  Future<UserEntity?> signUp(
      String name, String email, String password, String phone) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

// Ensure user is not null
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
