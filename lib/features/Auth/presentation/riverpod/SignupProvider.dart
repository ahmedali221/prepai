import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Auth/data/data%20source/auth_remote_data_source.dart';
import 'package:prepai/features/Auth/data/entities/user_entity.dart';
import 'package:prepai/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:prepai/features/Auth/domain/use_cases/sign_up_use_case.dart';

enum SignupState { initial, loading, success, error }

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
AuthRemoteDataSource authRemoteDataSource =
    new AuthRemoteDataSourceImpl(_firebaseAuth, _firestore);
AuthRepositoryImpl authRepositoryImpl =
    AuthRepositoryImpl(authRemoteDataSource);

class SignupNotifier extends StateNotifier<SignupState> {
  final SignUpUseCase _SignupUseCase;
  UserEntity? _user;
  String? _errorMessage;

  SignupNotifier(this._SignupUseCase) : super(SignupState.initial);

  UserEntity? get user => _user;
  String? get errorMessage => _errorMessage;

  Future<void> signup(
      String name, String Phone, String email, String password) async {
    state = SignupState.loading;
    try {
      final user = await _SignupUseCase.repository.remoteDataSource
          .signUp(name, Phone, email, password);
      if (user != null) {
        _user = user;
        state = SignupState.success;
      } else {
        _errorMessage = "User not found";
        state = SignupState.error;
      }
    } catch (e) {
      _errorMessage = e.toString();
      state = SignupState.error;
    }
  }

  void reset() {
    state = SignupState.initial;
    _user = null;
    _errorMessage = null;
  }
}

// Repository provider
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return authRepositoryImpl;
});

// Login use case provider
final signupUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignUpUseCase(repository);
});

// Login provider
final loginProvider = StateNotifierProvider<SignupNotifier, SignupState>((ref) {
  final SignupUseCase = ref.watch(signupUseCaseProvider);
  return SignupNotifier(SignupUseCase);
});
