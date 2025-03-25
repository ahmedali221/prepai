import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/di/di.dart';
import 'package:prepai/features/home/domain/use_cases/fetch_password_use_case.dart';

class UserPasswordNotifier extends StateNotifier<AsyncValue<String?>> {
  final FetchPasswordUseCase fetchPasswordUseCase;

  UserPasswordNotifier({required this.fetchPasswordUseCase})
      : super(const AsyncValue.loading());
  
  Future<void> fetchPassword() async {
    final result = await fetchPasswordUseCase.execute();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (data) => state = AsyncValue.data(data),
    );
  }
}

final userPasswordNotifierProvider = StateNotifierProvider<UserPasswordNotifier, AsyncValue<String?>>((ref) {
  final fetchPasswordUseCase = getIt<FetchPasswordUseCase>(); 
  return UserPasswordNotifier(fetchPasswordUseCase: fetchPasswordUseCase);
});