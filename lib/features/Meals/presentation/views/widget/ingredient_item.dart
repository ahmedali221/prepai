import 'package:flutter/material.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../domain/entities/meal_entity.dart';

class IngredientItem extends StatelessWidget {
  const IngredientItem({
    super.key,
    required this.ingred,
  });

  final Ingredient ingred;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: AppColors.cD9D9D9,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 15),
        SizedBox(
          child: Text(
            ingred.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.textStyle18.copyWith(
              color: AppColors.c001A3F,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Expanded(child: SizedBox(width: 5)),
        SizedBox(
          child: Text(
            "${ingred.quantity.toString()} pcs",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.textStyle18.copyWith(color: AppColors.c001A3F),
          ),
        ),
      ],
    );
  }
}
