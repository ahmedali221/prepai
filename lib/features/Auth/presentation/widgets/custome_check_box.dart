import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Styles.dart';

class CustomeCheckBox extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomeCheckBox({
    Key? key,
    required this.text,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
            side: BorderSide(color: Colors.white, width: 1),
          ),
        ),
        Text(
          text,
          style: AppStyles.textStyle16,
        ),
      ],
    );
  }
}
