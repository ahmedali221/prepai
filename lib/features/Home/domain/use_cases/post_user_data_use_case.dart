import 'package:prepai/features/Home/domain/repository/base_user_data_repo.dart';

class PosthUserDataUseCase {
  final BaseUserDataRepo baseUserDataRepo;

  PosthUserDataUseCase({required this.baseUserDataRepo});

  execute() async{
    await baseUserDataRepo.postUserData();
  }
}
