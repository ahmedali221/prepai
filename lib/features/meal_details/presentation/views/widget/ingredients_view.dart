import 'package:flutter/material.dart';
import '../../../../../Core/theme/app_colors.dart';

class IngredientsView extends StatelessWidget {
  const IngredientsView({
    super.key,
    //required this.model,
  });

  //final MealDetailsModel model;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const SizedBox(height: 10),
      //Text("total ingredients ${model.ingredients.length}"),
      const SizedBox(height: 25),
    ];
    // When you create the model, delete comments about it.
    /* delete it
    children.addAll(
      List.generate(model.ingredients.length, (int index) {
        return Column(
          children: [
            IngredientItem(ingred: model.ingredients[index]),
            const SizedBox(height: 10),
            const Divider(color: AppColors.c001A3F, thickness: .75),
            const SizedBox(height: 10),
          ],
        );
      }),
    );
    delete it */

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
