import 'package:flutter/material.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../../../Core/utils/constants.dart';

class RowTopRecipes extends StatelessWidget {
  const RowTopRecipes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppConsts.toprecipes,
          style: AppStyles.textStyle18,
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            AppConsts.seeall,
            style: AppStyles.textStyle18,
          ),
        ),
      ],
    );
  }
}
