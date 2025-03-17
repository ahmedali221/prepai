import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errorMessage;
  Failure(this.errorMessage);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(super.errorMessage);

  /// Factory constructor to map Firebase Authentication errors
  factory FirebaseFailure.fromAuthError(FirebaseAuthException e) {
    const errorMessages = {
      'email-already-in-use': 'This email is already in use.',
      'invalid-email': 'Invalid email format.',
      'weak-password': 'Password must be at least 8 characters long.',
      'user-not-found': 'No user found with this email.',
      'wrong-password': 'Incorrect password.',
      'too-many-requests': 'Too many failed attempts. Try again later.',
      'user-disabled': 'This account has been disabled.',
    };

    return FirebaseFailure(errorMessages[e.code] ??
        'An unknown authentication error occurred: ${e.code}');
  }

  /// Factory constructor to map Firestore errors
  factory FirebaseFailure.fromFirestoreError(FirebaseException e) {
    const errorMessages = {
      'permission-denied': 'You do not have permission to perform this action.',
      'not-found': 'Requested data not found.',
      'already-exists': 'This data already exists.',
      'unavailable': 'Service is currently unavailable. Try again later.',
      'deadline-exceeded': 'The request took too long. Try again later.',
      'resource-exhausted': 'Quota exceeded. Try again later.',
    };

    return FirebaseFailure(
        errorMessages[e.code] ?? 'A Firestore error occurred: ${e.code}');
  }
}
