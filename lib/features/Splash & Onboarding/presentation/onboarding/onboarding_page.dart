import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/features/Splash%20&%20Onboarding/presentation/onboarding/widgets/image_section.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});

  final GlobalKey<IntroductionScreenState> _introKey =
      GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF001A3F);

    return Scaffold(
      body: IntroductionScreen(
        key: _introKey,
        onDone: () => context.go('/login'),
        pages: [
          PageViewModel(
            title: 'Like in a Restaurant but at Home',
            body:
                "Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            image: buildImageSection(context, 'assets/images/Mask1.png'),
            decoration: _pageDecoration(primaryColor),
          ),
          PageViewModel(
            title: 'Delicious Meals Delivered',
            body:
                "Enjoy a variety of meals prepared by top chefs and delivered to your doorstep.",
            image: buildImageSection(context, 'assets/images/Mask3.png'),
            decoration: _pageDecoration(primaryColor),
          ),
          PageViewModel(
            title: 'Easily Order Online',
            body:
                "Browse through our menu, customize your orders, and pay with ease.",
            image: buildImageSection(context, 'assets/images/Mask2.png'),
            decoration: _pageDecoration(primaryColor),
          ),
        ],
        next: Icon(Icons.arrow_forward, color: primaryColor),
        skip: Text("Skip", style: TextStyle(color: primaryColor)),
        done: Text("Done", style: TextStyle(color: primaryColor)),
        back: Icon(Icons.arrow_back, color: primaryColor),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: primaryColor,
          color: primaryColor.withOpacity(0.5),
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        showNextButton: true,
        showDoneButton: true,
        showSkipButton: true,
        showBackButton: true,
      ),
    );
  }

  // Extracted method for reusability
  PageDecoration _pageDecoration(Color primaryColor) {
    return PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24, color: primaryColor),
      bodyTextStyle: TextStyle(fontSize: 18, color: primaryColor),
      imageFlex: 2,
    );
  }
}
