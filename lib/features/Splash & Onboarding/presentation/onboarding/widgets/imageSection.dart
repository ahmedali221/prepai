import 'package:flutter/material.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/presentation/onboarding/widgets/waveClipper.dart';

Widget buildImageSection(BuildContext context, String imagePath) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  return Stack(
    alignment: Alignment.topCenter,
    children: [
      ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: screenHeight * 0.5,
          color: Color(0xFF001A3F),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.10),
        child: Column(
          children: [
            Image.asset(
              'assets/images/Logo.png',
              height: screenHeight * 0.08,
            ),
            Spacer(),
            CircleAvatar(
              radius: screenWidth * 0.18,
              backgroundImage: AssetImage(imagePath),
            ),
          ],
        ),
      ),
    ],
  );
}
