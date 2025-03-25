import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/core/services/firebase_service.dart';
import 'package:prepai/features/Home/domain/repository/base_user_data_repo.dart';
import 'package:prepai/features/home/data/models/user_model.dart';

class UserDataRepo implements BaseUserDataRepo {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserDataRepo({required this.firebaseAuth, required this.firestore});
  @override
  Future<Either<FirebaseFailure, UserModel>> getUserData() async {
    final result =
        await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore)
            .fetchUserProfileData();
    return result.fold(
        (failure) => Left(failure), (data) => Right(UserModel.fromJson(data)));
  }

  @override
  Future postUserData() {
    // TODO: implement postUserData
    throw UnimplementedError();
  }

  @override
  Future<Either<FirebaseFailure, String?>> getUserPassword() async {
    return await FirebaseService(
            firebaseAuth: firebaseAuth, firestore: firestore)
        .getPassword();
  }
}
