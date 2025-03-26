import 'package:flutter/material.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../domain/entities/meal_entity.dart';

class DirectionView extends StatelessWidget {
  const DirectionView({
    super.key,
    required this.mealModel,
  });

  final Meal mealModel;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const SizedBox(height: 10),
      Text("total steps ${mealModel.steps.length}"),
    ];

    children.addAll(
      List.generate(mealModel.steps.length, (int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "step $index",
              style: AppStyles.textStyle20.copyWith(
              color: AppColors.c001A3F,
              fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              mealModel.steps[index],
              style: AppStyles.textStyle16.copyWith(
              color: AppColors.c001A3F,
              ),
            ),
          ],
        );
      }),
    );

    children.add(const SizedBox(height: 10));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
