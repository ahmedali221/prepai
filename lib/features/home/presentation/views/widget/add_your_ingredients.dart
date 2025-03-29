import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/Core/Routes/app_routes.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../../../Core/theme/app_styles.dart';

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
          onPressed: () {
            context.go(AppRouter.chatAI);
          },
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
