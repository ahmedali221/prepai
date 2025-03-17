import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class AppRouter {
  static const String kInitPage = '/';
  static const String kHomePage = '/home';
  static const String kMealPage = '/recommendation';
  static const String kLogin = '/login';
  static const String kSignup = '/signup';
}

final GoRouter router = GoRouter(
  initialLocation: AppRouter.kInitPage,
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text('Page Not Found')),
  ),
  routes: [
    GoRoute(
      path: AppRouter.kInitPage,
      pageBuilder: (context, state) => const MaterialPage(child: InitPage()),
    ),
    GoRoute(
      path: AppRouter.kHomePage,
      pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
    ),
    GoRoute(
      path: AppRouter.kMealPage,
      pageBuilder: (context, state) => const MaterialPage(child: MealPage()),
    ),
    GoRoute(
      path: AppRouter.kLogin,
      pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
    ),
    GoRoute(
      path: AppRouter.kSignup,
      pageBuilder: (context, state) => const MaterialPage(child: SignupPage()),
    ),
  ],
);
