import 'package:flutter/material.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/presentation/scaling_logo.dart';

class SplashPageBody extends StatefulWidget {
  const SplashPageBody({super.key});

  @override
  State<SplashPageBody> createState() => _SplashPageBodyState();
}

class _SplashPageBodyState extends State<SplashPageBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    initScalingAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScalingLogo(scaleAnimation: scaleAnimation),
    );
  }

  void initScalingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    scaleAnimation =
        Tween<double>(begin: 0.5, end: 1.0).animate(animationController);

    animationController.forward();
  }
}
