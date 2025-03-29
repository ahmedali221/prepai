import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/features/Meals/presentation/riverpod/meal_notifier.dart';
import 'package:prepai/features/Meals/presentation/riverpod/meal_provider.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../domain/entities/meal_entity.dart';

class TopBar extends ConsumerWidget {
  const TopBar({
    super.key,
    required this.mealModel,
  });

  final Meal mealModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(mealFavoriteProvider(mealModel).notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        IconButton(
          onPressed: () {
            isFav.toggleFavorite();
          },
          icon: Icon(
            mealModel.isFav ? Icons.favorite : Icons.favorite_border,
            color: AppColors.c001A3F,
          ),
        ),
      ],
    );
  }
}
