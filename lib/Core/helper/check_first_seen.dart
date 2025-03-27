import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/Core/Routes/App_Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void checkFirstSeen(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final userId = await storage.read(key: "userId");

  final bool? seen = prefs.getBool('seen');

  if (seen == null || seen == false) {
    // User has not seen the onboarding screen, navigate to it
    context.go(AppRouter.onboardingPage);

    prefs.setBool(
        'seen', true); // Set the flag to true after showing onboarding
  } else {
    if (userId != null) {
      // User is logged in, navigate to the main app
      context.go(AppRouter.kHomePage);
    }
    // User has already seen the onboarding screen, navigate to the main app
    context.go(AppRouter.kLogin);
  }
}
