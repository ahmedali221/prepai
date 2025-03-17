import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Styles.dart';

class CustomeDivider extends StatelessWidget {
  const CustomeDivider({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.white,
              thickness: 1,
              endIndent: 10,
            ),
          ),
          Text(
            text,
            style: AppStyles.textStyle16,
          ),
          Expanded(
            child: Divider(
              color: Colors.white,
              thickness: 1,
              indent: 10,
            ),
          ),
        ],
      ),
    );
  }
}
