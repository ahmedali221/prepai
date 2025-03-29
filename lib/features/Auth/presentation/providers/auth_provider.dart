import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/di/dep_inj.dart';

import 'package:prepai/features/Auth/domain/use_cases/auh_use_case.dart';
import 'package:prepai/features/Auth/presentation/providers/auth_notifier.dart';
import 'package:prepai/features/Auth/presentation/providers/auth_state.dart';
// Provider for AuthNotifier
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authUseCase = getIt<AuthUseCase>();
  return AuthNotifier(authUseCase);
});
