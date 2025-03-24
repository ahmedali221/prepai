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

  Future<Either<FirebaseFailure, Map<String, dynamic>?>>
      fetchUserProfileData() async {
    try {
      final userId = await storage.read(key: "userId");
      if (userId == null) {
        return Left(FirebaseFailure('User ID not found in secure storage.'));
      }
      DocumentSnapshot<Map<String, dynamic>> documentStream = await firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .get();
      if (!documentStream.exists) {
        return Left(FirebaseFailure('User document not found.'));
      }
      return Right(documentStream.data());
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }

  Future<Either<FirebaseFailure, String>> addNewMeal({
    required Map<String, dynamic> mealData,
  }) async {
    try {
      final userId = await storage.read(key: "userId");
      final mealsRef = firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersMealsCollectionName);
      await mealsRef.add(mealData);
      return Right('Meal added successfully!');
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }

  Future<Either<FirebaseFailure, List<Map<String, dynamic>>>>
      fetchUserMeals() async {
    try {
      final userId = await storage.read(key: "userId");
      if (userId == null) {
        return Left(FirebaseFailure('User ID not found in secure storage.'));
      }
      QuerySnapshot<Map<String, dynamic>> mealsSnapshot = await firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersMealsCollectionName)
          .get();
      if (mealsSnapshot.docs.isEmpty) {
        return Left(FirebaseFailure('No meals found for this user.'));
      }
      List<Map<String, dynamic>> mealsList = mealsSnapshot.docs
          .map((doc) => {"mealId": doc.id, ...doc.data()})
          .toList();

      return Right(mealsList);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }

  Future<void> updateUserDocData({required Map<String, dynamic> data}) async {
    final userId = await storage.read(key: "userId");
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

  Future<void> _savePassword(String password) async {
    await storage.write(key: 'userPassword', value: password);
  }

  Future<Either<FirebaseFailure, String?>> getPassword() async {
    try {
      final password = await storage.read(key: 'userPassword');
      return Right(password);
    } on Exception catch (e) {
      return Left(FirebaseFailure('error $e'));
    }
  }

  Future<Either<FirebaseFailure, String>> updatePassword(
      {required String newPassword}) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        await currentUser.updatePassword(newPassword);
        await storage.write(key: 'userPassword', value: newPassword);
        return Right("Password updated successfully!");
      } else {
        return Left(FirebaseFailure("No user is currently logged in."));
      }
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromAuthError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }

}
