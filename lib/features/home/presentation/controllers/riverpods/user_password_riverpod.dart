import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/di/di.dart';
import 'package:prepai/features/home/domain/use_cases/change_password_use_case.dart';
import 'package:prepai/features/home/domain/use_cases/fetch_password_use_case.dart';

class UserPasswordNotifier extends StateNotifier<AsyncValue<String?>> {
  final FetchPasswordUseCase fetchPasswordUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  UserPasswordNotifier(
      {required this.fetchPasswordUseCase, required this.changePasswordUseCase})
      : super(const AsyncValue.loading());

  Future<void> fetchPassword() async {
    final result = await fetchPasswordUseCase.execute();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (data) => state = AsyncValue.data(data),
    );
  }

  Future<void> changePassword({required String newPassword}) async {
    state = const AsyncValue.loading();
    final result = await changePasswordUseCase.execute(password: newPassword);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (data) async {
        await fetchPassword();
      },
    );
  }
}

final userPasswordNotifierProvider =
    StateNotifierProvider<UserPasswordNotifier, AsyncValue<String?>>((ref) {
  final fetchPasswordUseCase = getIt<FetchPasswordUseCase>();
  final changePasswordUseCase = getIt<ChangePasswordUseCase>();
  return UserPasswordNotifier(
      fetchPasswordUseCase: fetchPasswordUseCase,
      changePasswordUseCase: changePasswordUseCase);
});
