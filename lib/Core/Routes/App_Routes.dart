import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/features/Auth/presentation/pages/Login_Page.dart';
import 'package:prepai/features/Auth/presentation/pages/Signup_Page.dart';
import 'package:prepai/features/Meals/presentation/MealPage.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/InitPage.dart';
import '../../features/Home/presentation/views/screen/controller_screen.dart';

class AppRouter {
  static const String kinitPage = '/';
  static const String kHomePage = '/Home';
  static const String kMealPage = '/Recommendation';
  static const String kLogin = '/login';
  static const String kSignup = '/Signup';
}

final route = GoRouter(
    initialLocation: AppRouter.kinitPage,
    errorPageBuilder: (context, state) =>
        const MaterialPage(child: Scaffold(body: Text('Not Found'))),
    routes: [
      GoRoute(
        path: AppRouter.kinitPage,
        builder: (context, state) => InitPage(),
      ),
      GoRoute(
        path: AppRouter.kHomePage,
        builder: (context, state) => ControllerScreen(),
      ),
      GoRoute(
        path: AppRouter.kMealPage,
        builder: (context, state) => MealPage(),
      ),
      GoRoute(
        path: AppRouter.kLogin,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: AppRouter.kSignup,
        builder: (context, state) => SignupPage(),
      ),
    ]);
