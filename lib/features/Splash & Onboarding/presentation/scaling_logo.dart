import 'package:flutter/material.dart';
import 'package:prepai/Core/utils/assets.dart';

class ScalingLogo extends StatelessWidget {
  const ScalingLogo({super.key, required this.scaleAnimation});
  final Animation<double> scaleAnimation;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Image.asset(
        AppAssets.mainImage,
      ),
    );
  }
}
