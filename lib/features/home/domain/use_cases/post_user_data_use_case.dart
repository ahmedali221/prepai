import 'package:prepai/features/home/data/models/user_model.dart';
import 'package:prepai/features/home/domain/entities/user_profile_entity.dart';
import 'package:prepai/features/home/domain/repository/base_user_data_repo.dart';

class PostUserDataUseCase {
  final BaseUserDataRepo baseUserDataRepo;

  PostUserDataUseCase({required this.baseUserDataRepo});

  execute({required UserProfileEntity userProfile}) async {
     final userModel = UserModel.fromEntity(userProfile);
    await baseUserDataRepo.postUserData(data: userModel.toJson());
  }
}
