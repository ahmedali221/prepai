import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/di/dep_inj.dart';
import 'package:prepai/features/home/domain/entities/user_profile_entity.dart';
import 'package:prepai/features/home/domain/use_cases/fetch_user_data_use_case.dart';
import 'package:prepai/features/home/domain/use_cases/post_user_data_use_case.dart';

class UserProfileNotifier extends StateNotifier<AsyncValue<UserProfileEntity>> {
  final FetchUserDataUseCase _fetchUserDataUseCase;
  final PostUserDataUseCase _postUserDataUseCase;

  UserProfileNotifier(this._fetchUserDataUseCase, this._postUserDataUseCase)
      : super(const AsyncValue.loading());

  Future<void> fetchUserData() async {
    state = const AsyncValue.loading();
    final result = await _fetchUserDataUseCase.execute();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (data) => state = AsyncValue.data(data),
    );
  }

  Future<void> postUserData(
      {required String name,
      required String email,
      required String phone}) async {
    await _postUserDataUseCase.execute(
        userProfile: UserProfileEntity(
            userEmail: email, userName: name, userPhone: phone));
  }
}

final userProfileNotifierProvider =
    StateNotifierProvider<UserProfileNotifier, AsyncValue<UserProfileEntity>>(
        (ref) {
  final fetchUserDataUseCase = getIt<FetchUserDataUseCase>();
  final postUserDataUseCase = getIt<PostUserDataUseCase>();
  return UserProfileNotifier(fetchUserDataUseCase, postUserDataUseCase);
});
