import 'package:flutter/material.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../../../Core/theme/app_styles.dart';

class DirectionView extends StatelessWidget {
  const DirectionView({
    super.key,
    //required this.model,
  });

  //final MealDetailsModel model;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const SizedBox(height: 10),
      //Text("total steps ${model.steps.length}"),
    ];
    // When you create the model, delete comments about it.

    /* delete it
    children.addAll(
      List.generate(model.steps.length, (int index) {
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
              model.steps[index],
              style: AppStyles.textStyle16.copyWith(
              color: AppColors.c001A3F,
              ),
            )
          ],
        );
      }),
    );
     delete it  */

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
