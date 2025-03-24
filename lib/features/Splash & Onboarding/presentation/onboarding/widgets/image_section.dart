import 'package:flutter/material.dart';
import 'package:prepai/core/theme/app_colors.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/presentation/onboarding/widgets/wave_clipper.dart';

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
          color: AppColors.secondaryColor, 
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.10),
        child: Column(
          children: [
            Image.asset(
              'images/Logo.png',
              height: screenHeight * 0.08,
              color: AppColors.secondaryColor, 
            ),
            const Spacer(),
            CircleAvatar(
              radius: screenWidth * 0.18,
              backgroundColor: AppColors.secondaryColor, 
              child: CircleAvatar(
                radius: screenWidth * 0.175, 
                backgroundImage: AssetImage(imagePath),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
