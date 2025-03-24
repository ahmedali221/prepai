import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Styles.dart';
import 'package:prepai/Core/utils/constants.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppConsts.filter,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            AppConsts.reset,
            style: AppStyles.textStyle18,
          ),
        ),
      ],
    );
  }
}
