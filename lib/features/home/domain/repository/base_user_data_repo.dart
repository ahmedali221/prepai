import 'package:dartz/dartz.dart' show Either;
import 'package:prepai/features/Home/domain/entities/user_profile_entity.dart';


abstract class BaseUserDataRepo {
  Future<Either<String, UserProfileEntity>> getUserData({required String userId});
  Future postUserData();
}