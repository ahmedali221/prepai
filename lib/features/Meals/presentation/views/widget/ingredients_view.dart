import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/presentation/riverpod/meal_provider.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../domain/entities/meal_entity.dart';
import 'ingredient_item.dart';

class IngredientsView extends ConsumerWidget {
  const IngredientsView({
    super.key,
    required this.mealId,
  });

  final String mealId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meal = ref.watch(mealDetailProvider(mealId));

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text("Total ingredients: ${meal.ingredients.length}"),
          const SizedBox(height: 25),
          ...meal.ingredients.map((ingred) => Column(
            children: [
              IngredientItem(ingred: ingred),
              const SizedBox(height: 10),
              const Divider(color: AppColors.c001A3F, thickness: 0.75),
              const SizedBox(height: 10),
            ],
          )),
        ],
      ),
    );
  }
}