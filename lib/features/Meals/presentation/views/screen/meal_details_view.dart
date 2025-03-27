import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';
import 'package:prepai/features/Meals/presentation/riverpod/meal_notifier.dart';
import 'package:prepai/features/Meals/presentation/riverpod/meal_provider.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../widget/page_view_titles.dart';
import '../widget/top_bar.dart';

class MealDetailsView extends ConsumerWidget {
  const MealDetailsView({
    super.key,
    required this.mealId,
  });

  final String mealId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meal = ref.watch(mealDetailProvider(mealId));

    if (meal.id.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TopBar(mealModel: meal),
                  ),
                  Image.network(
                    //image
                    meal.image,
                    height: MediaQuery.sizeOf(context).height * .35,
                    width: MediaQuery.sizeOf(context).width,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    //name
                    meal.name,
                    style: AppStyles.largeTitleTextStyle.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${meal.subtitle}  .  ${meal.duration.inMinutes}min  .  ${meal.servings} servings",
                    style: AppStyles.textStyle18
                        .copyWith(color: AppColors.c8A8A8A),
                  ),
                  const SizedBox(height: 15),
                  PageViewTitles(mealId: meal.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
