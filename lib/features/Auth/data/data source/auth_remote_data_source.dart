import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity?> signUp(String name, String email, String password, String phone);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  Future<UserEntity?> signUp(String name, String email, String password, String phone) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      final user = UserEntity(
        uid: credential.user!.uid,
        name: name,
        email: email,
        phone: phone,
      );

      // Save user details to Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
      });

      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Sign-up failed";
    }
  }
}
