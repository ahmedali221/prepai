import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/Core/utils/firebase_constants.dart';
import 'package:prepai/core/services/firebase_service.dart';

class UserProfileRemoteDataSource extends FirebaseService {
  UserProfileRemoteDataSource(
      {required super.firebaseAuth, required super.firestore});

  @override
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

  @override
  Future<void> updateUserDocData({required Map<String, dynamic> data}) async {
    final userId = await storage.read(key: "userId");
    await firestore
        .collection(FirebaseConstants.usersCollectionName)
        .doc(userId)
        .update(data);
  }

  @override
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

  @override
    Future<Either<FirebaseFailure, String?>> getPassword() async {
    try {
      final password = await storage.read(key: 'userPassword');
      return Right(password);
    } on Exception catch (e) {
      return Left(FirebaseFailure('error $e'));
    }
  }
}
