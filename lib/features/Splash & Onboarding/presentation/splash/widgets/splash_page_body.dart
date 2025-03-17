import 'package:flutter/material.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/presentation/splash/scaling_logo.dart';

class SplashPageBody extends StatefulWidget {
  const SplashPageBody({super.key});

  @override
  State<SplashPageBody> createState() => _SplashPageBodyState();
}

class _SplashPageBodyState extends State<SplashPageBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> scaleAnimation;
  late final Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScalingLogo(
        scaleAnimation: scaleAnimation,
        slideAnimation: slideAnimation,
      ),
    );
  }

  void initAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    scaleAnimation =
        Tween<double>(begin: 0.5, end: 1.0).animate(animationController);
    slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(animationController);

    animationController.forward();
  }
}
