import 'package:dartz/dartz.dart';

enum RemoveFavoriteMealStatus {
  initial,
  loading,
  success,
  error,
}

class RemoveFavoriteMealState {
  final RemoveFavoriteMealStatus status;
  final String? errorMessage;
  RemoveFavoriteMealState({required this.status, this.errorMessage});
  factory RemoveFavoriteMealState.initial() =>
      RemoveFavoriteMealState(status: RemoveFavoriteMealStatus.initial);
  factory RemoveFavoriteMealState.loading() =>
      RemoveFavoriteMealState(status: RemoveFavoriteMealStatus.loading);

  factory RemoveFavoriteMealState.loaded(Either<String, void> message) =>
      RemoveFavoriteMealState(
        status: RemoveFavoriteMealStatus.success,
      );

  factory RemoveFavoriteMealState.error(String message) =>
      RemoveFavoriteMealState(
          status: RemoveFavoriteMealStatus.error, errorMessage: message);
}
