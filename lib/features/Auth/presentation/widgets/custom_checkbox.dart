import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Styles.dart';
import 'package:prepai/core/theme/app_colors.dart';

class CustomCheckBox extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color activeColor; 

  const CustomCheckBox({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    this.activeColor = AppColors.secondaryColor, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, 
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, 
          side: const BorderSide(color: Colors.white, width: 1),
        ),
        const SizedBox(width: 8), 
        Text(
          text,
          style: AppStyles.regularTextStyle,
        ),
      ],
    );
  }
}
