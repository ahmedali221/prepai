import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Styles.dart';
import 'package:prepai/core/theme/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final String text;
  final Color dividerColor; 

  const CustomDivider({
    super.key,
    required this.text,
    this.dividerColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: dividerColor,
              thickness: 1,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: AppStyles.smallTextStyle,
            
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Divider(
              color: dividerColor,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
