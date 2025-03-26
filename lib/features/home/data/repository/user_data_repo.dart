import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/home/data/datasources/remote_data_sources/user_profile_remote_data_source.dart';

import 'package:prepai/features/home/data/models/user_model.dart';
import 'package:prepai/features/home/domain/repository/base_user_data_repo.dart';

class UserDataRepo implements BaseUserDataRepo {
  final UserProfileRemoteDataSourceImp userProfileRemoteDataSourceImp;

  UserDataRepo({required this.userProfileRemoteDataSourceImp});

  @override
  Future<Either<FirebaseFailure, UserModel>> getUserData() async {
    final result = await userProfileRemoteDataSourceImp.fetchUserProfileData();
    return result.fold(
        (failure) => Left(failure), (data) => Right(UserModel.fromJson(data)));
  }

  @override
  Future<void> postUserData({required Map<String, dynamic> data}) async {
    await userProfileRemoteDataSourceImp.updateUserDocData(data: data);
  }

  @override
  Future<Either<FirebaseFailure, String?>> getUserPassword() async {
    return await userProfileRemoteDataSourceImp.getPassword();
  }

  @override
  Future<Either<FirebaseFailure, String>> changeUserPassword(
      {required String password}) async {
    return await userProfileRemoteDataSourceImp.updatePassword(newPassword: password);
  }
}
