enum AddFavoriteMealStatus {
  initial,
  loading,
  authenticated,
  error,
}

class AddFavoriteMealState {
  final AddFavoriteMealStatus status;
  final String? errorMessage;
  const AddFavoriteMealState({required this.status, this.errorMessage});

  factory AddFavoriteMealState.initial() =>
      const AddFavoriteMealState(status: AddFavoriteMealStatus.initial);
  // Loading state
  factory AddFavoriteMealState.loading() =>
      const AddFavoriteMealState(status: AddFavoriteMealStatus.loading);
  // Authenticated state
  factory AddFavoriteMealState.authenticated() =>
      const AddFavoriteMealState(status: AddFavoriteMealStatus.authenticated);
  // Error state
  factory AddFavoriteMealState.error(String message) => AddFavoriteMealState(
        status: AddFavoriteMealStatus.error,
        errorMessage: message,
      );
}
  
    // Initial state
   