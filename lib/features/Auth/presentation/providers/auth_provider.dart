import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/core/di/di.dart';
import 'package:prepai/features/auth/domain/use_cases/auh_use_case.dart';
import 'package:prepai/features/auth/presentation/providers/auth_notifier.dart';
import 'package:prepai/features/auth/presentation/providers/auth_state.dart';
// Provider for AuthNotifier
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authUseCase = getIt<AuthUseCase>();
  return AuthNotifier(authUseCase);
});
