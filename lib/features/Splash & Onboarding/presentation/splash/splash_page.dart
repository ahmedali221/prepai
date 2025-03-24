import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Colors.dart';
import 'package:prepai/core/routes/app_routes.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/presentation/splash/widgets/splash_page_body.dart';
import 'package:go_router/go_router.dart'; 

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      context.go(AppRouter.onboardingPage); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: const SplashPageBody(),
    );
  }
}
