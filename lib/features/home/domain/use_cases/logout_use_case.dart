import 'package:prepai/features/home/domain/repository/base_user_data_repo.dart';

class LogoutUseCase {
  final BaseUserDataRepo baseUserDataRepo;

  LogoutUseCase({required this.baseUserDataRepo});
  Future<void> execute() async{
    await baseUserDataRepo.logout();
  }
}
