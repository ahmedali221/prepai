import 'package:flutter/material.dart';
import '../../../../../Core/theme/App_Colors.dart';
import '../../../../../Core/theme/App_Styles.dart';

class AddYourIngredients extends StatelessWidget {
  const AddYourIngredients({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.c001A3F,
          ),
          onPressed: () {},
          child: Text(
            "Add Your Ingredients",
            style: AppStyles.textStyle14.copyWith(
              color: AppColors.cFFFFFF,
            ),
          ),
        ),
      ],
    );
  }
}
