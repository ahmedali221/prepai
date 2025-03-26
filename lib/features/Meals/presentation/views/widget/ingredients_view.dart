import 'package:flutter/material.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../domain/entities/meal_entity.dart';
import 'ingredient_item.dart';

class IngredientsView extends StatelessWidget {
  const IngredientsView({
    super.key,
    required this.mealModel,
  });

  final Meal mealModel;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const SizedBox(height: 10),
      Text("total ingredients ${mealModel.ingredients.length}"),
      const SizedBox(height: 25),
    ];

    children.addAll(
      List.generate(mealModel.ingredients.length, (int index) {
        return Column(
          children: [
            IngredientItem(ingred: mealModel.ingredients[index]),
            const SizedBox(height: 10),
            const Divider(color: AppColors.c001A3F, thickness: .75),
            const SizedBox(height: 10),
          ],
        );
      }),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
