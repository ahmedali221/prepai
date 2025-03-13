import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final Color color;
  final void Function()? ontap;

  const SocialButton(
      {super.key,
      required this.onTap,
      required this.color,
      required this.image,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width * 0.15,
        height: height * 0.15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: SizedBox(
            width: width * 0.08,
            height: height * 0.08,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
