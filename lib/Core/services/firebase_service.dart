import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prepai/Core/utils/firebase_constants.dart';

class FirebaseService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseService({required this.firebaseAuth, required this.firestore});

  Future<UserCredential> signUp(String email, String password) {
    return firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> login(String email, String password) {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  Stream<dynamic> fetchDocumentStream(
      {required String userId}) {
    Stream documentStream = FirebaseFirestore.instance
        .collection(FirebaseConstants.usersCollectionName)
        .doc(userId)
        .snapshots();
    return documentStream;
  }
}
