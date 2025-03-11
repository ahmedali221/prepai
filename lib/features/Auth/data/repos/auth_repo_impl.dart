import 'package:dartz/dartz.dart';
import 'package:prepai/features/Auth/data/data%20source/auth_remote_data_source.dart';
import 'package:prepai/features/Auth/domain/models/user_model.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, UserModel>> signUp(String name, String email, String password, String phone) async{
    try {
      final user = await remoteDataSource.signUp(name, email, password, phone);
      return Right(UserModel(uid: user!.uid, name: user.name, email: user.email, phone: user.phone));
    } catch (e) {
      return Left(e.toString());
    }
  }
}