import 'package:flutter/material.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../../../Core/theme/app_colors.dart';

class NutritionItem extends StatelessWidget {
  const NutritionItem({
    super.key,
    required this.type,
    required this.amount,
  });

  final String type;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.c001A3F,
          width: 4,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            amount,
            style: AppStyles.textStyle14.copyWith(color: AppColors.c001A3F),
          ),
          const SizedBox(height: 5),
          Text(
            type,
            style: AppStyles.textStyle14.copyWith(color: AppColors.c001A3F),
          ),
        ],
      ),
    );
  }
}
