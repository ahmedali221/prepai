import 'package:dartz/dartz.dart';
import 'package:prepai/features/Home/domain/entities/user_profile_entity.dart';
import 'package:prepai/features/Home/domain/repository/base_user_data_repo.dart';

class FetchUserDataUseCase {
  final BaseUserDataRepo baseUserDataRepo;

  FetchUserDataUseCase({required this.baseUserDataRepo});

  Future<Either<String, UserProfileEntity>> execute(
      {required String userId}) async {
    return await baseUserDataRepo.getUserData(userId: userId);
  }
}
