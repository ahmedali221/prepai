import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/presentation/riverpod/meal_provider.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../../../Core/theme/app_colors.dart';

import 'nutrition_item.dart';

class SummaryView extends ConsumerWidget {
  const SummaryView({
    super.key,
    required this.mealId,
  });

  final String mealId;

  @override
  Widget build(BuildContext contex, WidgetRef ref) {
    final meal = ref.watch(mealDetailProvider(mealId));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          //model.summary
          Text(
            meal.summary,
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
                    '${meal.nutrition.protein.toInt()}g',
              ),
              NutritionItem(
                type: "carp",
                amount:
                    '${meal.nutrition.carbs.toInt()}g',
              ),
              NutritionItem(
                type: "fat",
                amount:
                    '${meal.nutrition.fat.toInt()}g',
              ),
              NutritionItem(
                type: "kcal",
                amount:
                    '${meal.nutrition.kcal.toInt()}',
              ),
              NutritionItem(
                  type: "vitamenes",
                  amount: '${meal.nutrition.vitamins.toInt()}mg',
                  ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
