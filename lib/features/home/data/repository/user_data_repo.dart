import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/core/services/firebase_service.dart';

import 'package:prepai/features/home/data/models/user_model.dart';
import 'package:prepai/features/home/domain/repository/base_user_data_repo.dart';

class UserDataRepo implements BaseUserDataRepo {
  final FirebaseService firebaseService;

  UserDataRepo({required this.firebaseService});

  @override
  Future<Either<FirebaseFailure, UserModel>> getUserData() async {
    final result = await firebaseService.fetchUserProfileData();
    return result.fold(
        (failure) => Left(failure), (data) => Right(UserModel.fromJson(data)));
  }

  @override
  Future<void> postUserData({required Map<String, dynamic> data}) async {
    await firebaseService.updateUserDocData(data: data);
  }

  @override
  Future<Either<FirebaseFailure, String?>> getUserPassword() async {
    return await firebaseService.getPassword();
  }

  @override
  Future<Either<FirebaseFailure, String>> changeUserPassword(
      {required String password}) async {
    return await firebaseService.updatePassword(newPassword: password);
  }
}
