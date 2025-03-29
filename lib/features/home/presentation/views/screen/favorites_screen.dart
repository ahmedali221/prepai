import 'package:flutter/material.dart';
import '../widget/recipes_builder.dart';
import '../widget/side_bar.dart';
import '../widget/side_bar_and_notifications.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const Sidebar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const SideBarAndNotifications(),
            SizedBox(height: screenHeight * 0.015),
            RecipesBuilder(true),
          ],
        ),
      ),
    );
  }
}
