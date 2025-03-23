import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/Core/utils/firebase_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  final storage = FlutterSecureStorage();
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseService({required this.firebaseAuth, required this.firestore});

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<Either<FirebaseFailure, String>> signUp(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    try {
      UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _addUserDataToDoc(
          email: email, name: name, phone: phone, user: user);
      await _setLoggedIn(true);
      return Right('User signed up successfully!');
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromAuthError(e));
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }

  Future<Either<FirebaseFailure, String>> login(
      String email, String password) async {
    try {
      UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await storage.write(key: "userId", value: user.user!.uid);
      await _setLoggedIn(true);
      return Right("Loged in Succefully");
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      await storage.deleteAll();
      await _setLoggedIn(false);
    } on FirebaseException catch (e) {
      // TODO
    }
  }

  Either<FirebaseFailure, Stream<DocumentSnapshot<Map<String, dynamic>>>>
      fetchDocStream({required String userId}) {
    try {
      Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream = firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .snapshots();
      return Right(documentStream);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }

  Future<void> updateDoc(
      {required String userId, required Map<String, dynamic> data}) async {
    await firestore
        .collection(FirebaseConstants.usersCollectionName)
        .doc(userId)
        .update(data);
  }

  Future<void> _addUserDataToDoc(
      {required String email,
      required String phone,
      required String name,
      required UserCredential user}) async {
    await firestore
        .collection(FirebaseConstants.usersCollectionName)
        .doc(user.user!.uid)
        .set({'name': name, 'email': email, 'phone': phone});
  }

  Future<void> _setLoggedIn(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool('isLoggedIn', value);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await _prefs;
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
