import 'package:flutter/material.dart';
import 'package:prepai/Core/utils/assets.dart';

class ScalingLogo extends StatelessWidget {
  const ScalingLogo({
    super.key,
    required this.scaleAnimation,
    required this.slideAnimation,
  });

  final Animation<double> scaleAnimation;
  final Animation<Offset> slideAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Image.asset(
          AppAssets.mainImage,
        ),
      ),
    );
  }
}
