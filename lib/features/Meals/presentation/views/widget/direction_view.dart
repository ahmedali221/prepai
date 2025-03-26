import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/presentation/riverpod/meal_provider.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../domain/entities/meal_entity.dart';

class DirectionView extends ConsumerWidget {
  const DirectionView({
    super.key,
    required this.mealId,
  });

  final String mealId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meal = ref.watch(mealDetailProvider(mealId));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text("Total Steps: ${meal.steps.length}"),
          const SizedBox(height: 10),
          ...List.generate(meal.steps.length, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Step ${index + 1}",
                  style: AppStyles.textStyle20.copyWith(
                    color: AppColors.c001A3F,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  meal.steps[index],
                  style: AppStyles.textStyle16.copyWith(
                    color: AppColors.c001A3F,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          }),
        ],
      ),
    );
  }
}