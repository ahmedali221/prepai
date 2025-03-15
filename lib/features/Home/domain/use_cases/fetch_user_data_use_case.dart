import 'package:prepai/features/Home/domain/repository/base_user_data_repo.dart';

class FetchUserDataUseCase {
  final BaseUserDataRepo baseUserDataRepo;

  FetchUserDataUseCase({required this.baseUserDataRepo});

  execute() async{
    await baseUserDataRepo.getUserData();
  }
}
