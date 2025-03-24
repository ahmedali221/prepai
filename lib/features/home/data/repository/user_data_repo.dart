import 'package:dartz/dartz.dart';
import 'package:prepai/features/Home/data/data_source/user_remote_data_source.dart';
import 'package:prepai/features/Home/domain/entities/user_profile_entity.dart';
import 'package:prepai/features/Home/domain/repository/base_user_data_repo.dart';

class UserDataRepo implements BaseUserDataRepo {
  final userRemoteDataSource = UserRemoteDataSource();
  @override
  Future<Either<String, UserProfileEntity>> getUserData({required String userId}) async{
    final result = await userRemoteDataSource.getUserProfile(userId: userId);

    return result.fold(
      (failure) => Left(failure), 
      (userModel) => Right(userModel.toEntity()),
    );
  }

  @override
  Future postUserData() {
    // TODO: implement postUserData
    throw UnimplementedError();
  }
}
