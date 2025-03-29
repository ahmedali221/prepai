import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/features/Auth/presentation/pages/login_page.dart';
import 'package:prepai/features/Auth/presentation/pages/sign_up_page.dart';
import 'package:prepai/features/Meals/presentation/views/screen/meal_details_view.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/presentation/onboarding/onboarding_page.dart';
import 'package:prepai/features/home/presentation/views/screen/favorites_screen.dart';
import 'package:prepai/features/home/presentation/views/screen/home_screen.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/presentation/splash/splash_page.dart';
import 'package:prepai/features/food_chat/presentation/pages/chat_page.dart';
import '../../features/home/presentation/views/screen/controller_screen.dart';
import 'package:prepai/features/home/presentation/views/screen/profile_screen.dart';

class AppRouter {
  static const String kInitPage = '/';
  static const String onboardingPage = '/onboarding';
  static const String kHomePage = '/home';
  static const String kMealPage = '/recommendation';
  static const String kLogin = '/login';
  static const String kSignup = '/signup';
  static const String kFavourites = '/favourites';
  static const String kProfile = '/profile';
  static const String kMealDetails = '/mealdetails';
  static const String chatAI = '/chat';
}

final GoRouter router = GoRouter(
  initialLocation: AppRouter.kInitPage,
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text('Page Not Found')),
  ),
  routes: [
    GoRoute(
      path: AppRouter.kInitPage,
      pageBuilder: (context, state) => const MaterialPage(child: SplashPage()),
    ),
    GoRoute(
      path: AppRouter.onboardingPage,
      pageBuilder: (context, state) => MaterialPage(child: OnBoardingPage()),
    ),
    GoRoute(
      path: AppRouter.kHomePage,
      pageBuilder: (context, state) =>
          const MaterialPage(child: ControllerScreen()),
    ),
    GoRoute(
      path: AppRouter.kMealPage,
      pageBuilder: (context, state) =>
          const MaterialPage(child: MyHomeScreen()),
    ),
    GoRoute(
      path: AppRouter.kLogin,
      pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
    ),
    GoRoute(
      path: AppRouter.kSignup,
      pageBuilder: (context, state) => const MaterialPage(child: SignupPage()),
    ),
    GoRoute(
      path: AppRouter.kFavourites,
      pageBuilder: (context, state) =>
          const MaterialPage(child: FavoriteScreen()),
    ),
    GoRoute(
      path: AppRouter.kProfile,
      pageBuilder: (context, state) =>
          const MaterialPage(child: ProfileScreen()),
    ),
    GoRoute(
      path: '${AppRouter.kMealDetails}/:mealId',
      pageBuilder: (context, state) {
        final mealId = state.pathParameters['mealId'];
        return MaterialPage(child: MealDetailsView(mealId: mealId??""));
      },
    ),
    GoRoute(
      path: AppRouter.chatAI,
      pageBuilder: (context, state) => const MaterialPage(child: ChatPage()),
    ),
  ],
);
