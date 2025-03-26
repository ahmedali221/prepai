import 'package:flutter/material.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../../../Core/theme/app_colors.dart';
import 'nutrition_item.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({
    super.key,
    //required this.model,
  });

  //final MealDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          //model.summary
          Text('model.summary', style: TextStyle(color: AppColors.c001A3F)),
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
                amount: '',//"${model.nutritions.protein.toInt()}g",
              ),
              NutritionItem(
                type: "carp",
                amount: '',//"${model.nutritions.carp.toInt()}g",
              ),
              NutritionItem(
                type: "fat",
                amount: '',//"${model.nutritions.fat.toInt()}g",
              ),
              NutritionItem(
                type: "kcal",
                amount: ''//"${model.nutritions.kcal.toInt()}",
              ),
              NutritionItem(
                type: "vitamenes",
                amount: ''//"${model.nutritions.vitamenes.toInt()}mg",
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
