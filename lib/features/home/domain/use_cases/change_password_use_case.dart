import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/home/domain/repository/base_user_data_repo.dart';

class ChangePasswordUseCase {
  final BaseUserDataRepo baseUserDataRepo;

  ChangePasswordUseCase({required this.baseUserDataRepo});
  Future<Either<FirebaseFailure, String>> execute(
      {required String password}) async {
    return baseUserDataRepo.changeUserPassword(password: password);
  }
}
