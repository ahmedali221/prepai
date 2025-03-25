import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/features/Auth/presentation/pages/login_page.dart';
import 'package:prepai/features/Auth/presentation/pages/sign_up_page.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/presentation/onboarding/onboarding_page.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/presentation/splash/splash_page.dart';
import 'package:prepai/features/home/presentation/home_page.dart';
import 'package:prepai/features/home/presentation/views/screen/profile_screen.dart';
import 'package:prepai/features/meals/presentation/meal_page.dart';

class AppRouter {
  static const String kInitPage = '/';
  static const String onboardingPage = '/onboarding';
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
      pageBuilder: (context, state) => const MaterialPage(child: ProfileScreen()),
    ),
    GoRoute(
      path: AppRouter.onboardingPage,
      pageBuilder: (context, state) => MaterialPage(child: OnBoardingPage()),
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
