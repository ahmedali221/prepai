import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/home/domain/entities/user_profile_entity.dart';
import 'package:prepai/features/home/domain/repository/base_user_data_repo.dart';


class FetchUserDataUseCase {
  final BaseUserDataRepo baseUserDataRepo;

  FetchUserDataUseCase({required this.baseUserDataRepo});

  Future<Either<FirebaseFailure, UserProfileEntity>> execute() async {
    final result = await baseUserDataRepo.getUserData();
    return result.fold(
        (error) => Left(error),
        (data) => Right(UserProfileEntity(
            userEmail: data.userEmail,
            userName: data.userName,
            userPhone: data.userPhone)));
  }
}
