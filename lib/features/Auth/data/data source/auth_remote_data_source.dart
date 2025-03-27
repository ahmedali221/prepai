import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/Core/services/firebase_service.dart';
import 'package:prepai/Core/utils/firebase_constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource extends FirebaseService {
  AuthRemoteDataSource({required super.firebaseAuth, required super.firestore});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  final storage = FlutterSecureStorage();
  @override
  final FirebaseAuth firebaseAuth;
  @override
  final FirebaseFirestore firestore;

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  AuthRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.firestore});

  @override
  Future<Either<FirebaseFailure, String>> addNewMeal(
      {required Map<String, dynamic> mealData}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<FirebaseFailure, List<Map<String, dynamic>>>> fetchUserMeals() {
    throw UnimplementedError();
  }

  @override
  Future<Either<FirebaseFailure, Map<String, dynamic>?>>
      fetchUserProfileData() {
    throw UnimplementedError();
  }

  @override
  Future<Either<FirebaseFailure, String?>> getPassword() {
    throw UnimplementedError();
  }

  @override
  Future<Either<FirebaseFailure, String>> login(
      {required String email, required String password}) async {
    try {
      UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user.user != null) {
        await storage.write(key: "userId", value: user.user!.uid);
        await _setLoggedIn(true);
        await _savePassword(password);
        return Right("Logged in Successfully");
      } else {
        return Left(FirebaseFailure("Failed to retrieve user details."));
      }
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }


  @override
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
      if (user.user != null) {
        await storage.write(key: "userId", value: user.user!.uid);
        await _setLoggedIn(true);
        await _savePassword(password);
        await _addUserDataToDoc(
            email: email, name: name, phone: phone, user: user);
        return Right('User signed up successfully!');
      } else {
        return Left(FirebaseFailure('User is null after signup.'));
      }
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromAuthError(e));
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }

  @override
  Future<Either<FirebaseFailure, String>> updatePassword(
      {required String newPassword}) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserDocData({required Map<String, dynamic> data}) {
    throw UnimplementedError();
  }

  Future<void> _savePassword(String password) async {
    await storage.write(key: 'userPassword', value: password);
  }

  Future<void> _setLoggedIn(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool('isLoggedIn', value);
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

  @override
  Future<Either<FirebaseFailure, String>> logout() async {
    try {
      await firebaseAuth.signOut();
      await storage.deleteAll();
      await _setLoggedIn(false);
      return Right('Logged out successfully!');
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromAuthError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }
}
