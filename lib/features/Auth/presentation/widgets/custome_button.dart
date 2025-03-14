import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Styles.dart';

class CustomeButton extends StatelessWidget {
  const CustomeButton(
      {super.key,
      required this.text,
      required this.color,
      required this.onTap});

  final String text;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 1,
        height: height * 0.07,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: AppStyles.textStyle21,
          ),
        ),
      ),
    );
  }
}
