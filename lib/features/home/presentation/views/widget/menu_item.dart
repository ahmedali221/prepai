import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String imagePath;
  final String title;

  const MenuItem({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 100, top: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              color: const Color(0xff001A3F),
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xff001A3F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
