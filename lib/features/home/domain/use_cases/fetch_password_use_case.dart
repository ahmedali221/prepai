import 'package:dartz/dartz.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/home/domain/repository/base_user_data_repo.dart';

class FetchPasswordUseCase {
  final BaseUserDataRepo baseUserDataRepo;

  FetchPasswordUseCase({required this.baseUserDataRepo});
  Future<Either<FirebaseFailure, String?>> execute() async {
    final result = await baseUserDataRepo.getUserPassword();
    return result.fold(
        (error) => Left(error),
        (data) => Right(data));
  }
}