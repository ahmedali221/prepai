import 'package:flutter/material.dart';
import 'package:prepai/Core/utils/assets.dart';

class ScalingLogo extends StatelessWidget {
  const ScalingLogo({super.key, required this.scaleAnimation});
  final Animation<Offset> scaleAnimation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) => SlideTransition(
        position: scaleAnimation,
        child: Image.asset(
          AppAssets.mainImage,
        ),
      ),
    );
  }
}
