import 'package:flutter/material.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../domain/entities/meal_entity.dart';
import 'nutrition_item.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({
    super.key,
    required this.mealModel,
  });

  final Meal mealModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          //model.summary
          Text(
            mealModel.summary,
            style: TextStyle(color: AppColors.c001A3F),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                "nutrations",
                style: AppStyles.textStyle20.copyWith(
                  color: AppColors.c001A3F,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              NutritionItem(
                type: "protein",
                amount:
                    '${mealModel.nutrition.protein.toInt()}g',
              ),
              NutritionItem(
                type: "carp",
                amount:
                    '${mealModel.nutrition.carbs.toInt()}g',
              ),
              NutritionItem(
                type: "fat",
                amount:
                    '${mealModel.nutrition.fat.toInt()}g',
              ),
              NutritionItem(
                type: "kcal",
                amount:
                    '${mealModel.nutrition.kcal.toInt()}',
              ),
              NutritionItem(
                  type: "vitamenes",
                  amount: '${mealModel.nutrition.vitamins.toInt()}mg',
                  ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
