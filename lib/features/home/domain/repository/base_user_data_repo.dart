import 'package:dartz/dartz.dart' show Either;
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/home/data/models/user_model.dart';

abstract class BaseUserDataRepo {
  Future<Either<FirebaseFailure, UserModel>> getUserData();
  Future<Either<FirebaseFailure, String?>> getUserPassword();
  Future<void> postUserData({required Map<String, dynamic> data});
  Future<Either<FirebaseFailure, String>> changeUserPassword(
      {required String password});
  Future<void> logout();
}
