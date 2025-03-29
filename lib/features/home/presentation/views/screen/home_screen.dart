import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/theme/App_Colors.dart';
import 'package:prepai/Core/theme/App_Styles.dart';
import 'package:prepai/features/home/presentation/controllers/meals_riverpod/Riverpod/Meal_Provider.dart';
import '../widget/add_your_ingredients.dart';
import '../widget/recipes_builder.dart';
import '../widget/row_top_recipes.dart';
import '../widget/search_and_filter.dart';
import '../widget/side_bar.dart';
import '../widget/side_bar_and_notifications.dart';

class MyHomeScreen extends ConsumerWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isFiltered = ref.watch(isFilteredProvider);
    return Scaffold(
      drawer: const Sidebar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),
            const SideBarAndNotifications(),
            SizedBox(height: screenHeight * 0.015),
            const SearchAndFilter(),
            SizedBox(height: screenHeight * 0.03),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: AddYourIngredients(),
            ),
            SizedBox(height: screenHeight * 0.015),
            const Padding(
              padding: EdgeInsets.all(10),
              child: RowTopRecipes(),
            ),
            SizedBox(height: screenHeight * 0.015),
            if (isFiltered)
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.filter_list,
                      color: AppColors.c001A3F,
                      size: 20,
                    ),
                    Text(
                      ' Filtered Recipes',
                      style: AppStyles.textStyleBold20.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        ref.read(mealProvider.notifier).fetchData();
                        ref.read(isFilteredProvider.notifier).state = false;
                      },
                      child: Text(
                        'Clear',
                        style: AppStyles.textStyle14.copyWith(
                          color: AppColors.c001A3F,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: RecipesBuilder(false),
            ),
          ],
        ),
      ),
    );
  }
}
