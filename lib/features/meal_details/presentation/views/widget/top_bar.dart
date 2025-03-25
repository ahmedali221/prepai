import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Core/theme/app_colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    //required this.mealModel,
  });

  //final MealDetailsModel mealModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        IconButton(
          onPressed: () async {},
          icon: Icon(
            //mealModel.isFav ? Icons.favorite : Icons.favorite_border,
            Icons.favorite,
            color: AppColors.c001A3F,
          ),
        ),
      ],
    );
  }
}
