import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';

abstract class FirebaseService {
  final storage = FlutterSecureStorage();
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseService({required this.firebaseAuth, required this.firestore});

  Future<Either<FirebaseFailure, String>> signUp(
      {required String email,
      required String password,
      required String phone,
      required String name});

  Future<Either<FirebaseFailure, String>> login(
      {required String email, required String password});

  Future<Either<FirebaseFailure, String>> logout();

  Future<Either<FirebaseFailure, Map<String, dynamic>?>> fetchUserProfileData();

  Future<Either<FirebaseFailure, String>> addNewMeal({
    required Map<String, dynamic> mealData,
  });

  Future<Either<FirebaseFailure, List<Map<String, dynamic>>>> fetchUserMeals();

  Future<void> updateUserDocData({required Map<String, dynamic> data});

  Future<Either<FirebaseFailure, String?>> getPassword();

  Future<Either<FirebaseFailure, String>> updatePassword(
      {required String newPassword});
}