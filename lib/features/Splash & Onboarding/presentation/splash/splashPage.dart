import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Colors.dart';
import 'package:prepai/Core/utils/assets.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/presentation/splash/widgets/splash_page_body.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SplashPageBody(),
    );
  }
}
