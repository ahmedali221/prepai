import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Auth/data/repositories/auth_repository.dart';
import 'package:prepai/features/Auth/domain/entities/user_entity.dart';
import 'package:prepai/features/Auth/domain/use_cases/login_usecase.dart';

enum LoginState { initial, loading, success, error }

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;
  UserEntity? _user;
  String? _errorMessage;

  LoginNotifier(this._loginUseCase) : super(LoginState.initial);

  UserEntity? get user => _user;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    state = LoginState.loading;
    try {
      final user = await _loginUseCase.execute(email, password);
      if (user != null) {
        _user = user;
        state = LoginState.success;
      } else {
        _errorMessage = "User not found";
        state = LoginState.error;
      }
    } catch (e) {
      _errorMessage = e.toString();
      state = LoginState.error;
    }
  }

  void reset() {
    state = LoginState.initial;
    _user = null;
    _errorMessage = null;
  }
}

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Login use case provider
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

// Login provider
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  return LoginNotifier(loginUseCase);
});