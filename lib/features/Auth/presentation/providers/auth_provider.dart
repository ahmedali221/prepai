import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:prepai/features/Auth/domain/repos/auth_repo.dart';
import 'package:prepai/features/Auth/presentation/providers/auth_notifier.dart';
import 'package:prepai/features/Auth/presentation/providers/auth_remote_datasource_provider.dart';
import 'package:prepai/features/Auth/presentation/providers/auth_state.dart';

// Provider for AuthRepositoryImpl
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});

// Provider for AuthNotifier
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthNotifier(authRepository);
});
