import 'package:firebase_auth/firebase_auth.dart';
import 'package:prepai/features/Auth/data/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> login(String email, String password) async {

    await Future.delayed(const Duration(seconds: 2));

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );final User? user = userCredential.user;
      if (user != null) {
        return UserModel(
          uid: user.uid,
          email: user.email ?? "",
          name: user.displayName ?? "",
        );
      } else {
        throw Exception('User not found');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e));
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }


  Future<void> logout() async {
    await _auth.signOut();
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email';
      case 'wrong-password':
        return 'Wrong password';
      case 'invalid-email':
        return 'Invalid email format';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }
}