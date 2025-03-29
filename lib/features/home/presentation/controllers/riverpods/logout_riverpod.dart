import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/di/dep_inj.dart';
import 'package:prepai/features/home/domain/use_cases/logout_use_case.dart';


// Create a provider for state management
final logoutStateProvider = StateNotifierProvider<LogoutNotifier, AsyncValue<void>>((ref) {
  final logoutUseCase = getIt<LogoutUseCase>();
  return LogoutNotifier(logoutUseCase);
});

class LogoutNotifier extends StateNotifier<AsyncValue<void>> {
  final LogoutUseCase _logoutUseCase;
  LogoutNotifier(this._logoutUseCase) : super(const AsyncValue.data(null));

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await _logoutUseCase.execute();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
