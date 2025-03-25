import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/di/di.dart';
import 'package:prepai/features/Home/domain/entities/user_profile_entity.dart';
import 'package:prepai/features/home/domain/use_cases/fetch_user_data_use_case.dart';

class UserProfileNotifier extends StateNotifier<AsyncValue<UserProfileEntity>> {
  final FetchUserDataUseCase _fetchUserDataUseCase;
  UserProfileNotifier(this._fetchUserDataUseCase)
      : super(const AsyncValue.loading());
  AsyncValue<UserProfileEntity> get userProfileState => state;

  Future<void> fetchUserData() async {
    state = const AsyncValue.loading();
    final result = await _fetchUserDataUseCase.execute();

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (data) => state = AsyncValue.data(data),
    );
  }
}

final userProfileNotifierProvider = StateNotifierProvider<UserProfileNotifier, AsyncValue<UserProfileEntity>>((ref) {
  final fetchUserDataUseCase = getIt<FetchUserDataUseCase>();
  return UserProfileNotifier(fetchUserDataUseCase);
});
