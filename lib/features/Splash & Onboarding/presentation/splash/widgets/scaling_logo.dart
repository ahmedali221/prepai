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
        child: Container(
          width: 120, // Adjust size as needed
          height: 120,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            // color: Colors.white, // White circle background
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Padding inside the circle
            child: Image.asset(AppAssets.loginLogo),
          ),
        ),
      ),
    );
  }
}
