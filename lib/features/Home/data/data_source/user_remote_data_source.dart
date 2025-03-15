import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../models/user_model.dart';

class UserRemoteDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Either<String, UserModel>> getUserProfile(
      {required String userId}) async {
    CollectionReference users = firestore.collection("users");
    final docSnapShots = await users.doc(userId).get();
    if (docSnapShots.exists && docSnapShots.data() != null) {
      return Right(
          UserModel.fromJson(docSnapShots.data() as Map<String, dynamic>));
    } else {
      return Left("sorry this user doesn't exist or no fields available");
    }
  }

  // Future<void> postUserProfile(UserModel user) async {
  //   await firestore.collection("users").doc(user.userEmail).set(user.toJson());
  // }
}

