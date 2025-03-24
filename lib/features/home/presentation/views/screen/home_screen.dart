import 'package:flutter/material.dart';
import '../widget/add_your_ingredients.dart';
import '../widget/recipes_builder.dart';
import '../widget/row_top_recipes.dart';
import '../widget/search_and_filter.dart';
import '../widget/side_bar.dart';
import '../widget/side_bar_and_notifications.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const RecipesBuilder();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
