import 'package:flutter/material.dart';
import 'package:prepai/features/Meals/domain/entities/meal_entity.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../widget/page_view_titles.dart';
import '../widget/top_bar.dart';

class MealDetailsView extends StatelessWidget {
  final Meal mealModel; // Pass the meal object

  const MealDetailsView({
    super.key,
    required this.mealModel,
  });

  //final MealDetailsModel mealModel;

  @override
  Widget build(BuildContext context) {
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
                    child: TopBar(
                      //mealModel: mealModel,
                    ),
                  ),
                  Image.network(
                    //image
                    mealModel.image,
                    height: MediaQuery.sizeOf(context).height * .35,
                    width: MediaQuery.sizeOf(context).width,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    //name
                    mealModel.name,
                    style: AppStyles.largeTitleTextStyle.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${mealModel.subtitle}  .  ${mealModel.duration.inMinutes}min  .  ${mealModel.servings} servings",
                    //"${mealModel.subtitle} . ${mealModel.duration.inMinutes}min . ${mealModel.serving} serving",
                    style: AppStyles.textStyle18.copyWith(color: AppColors.c8A8A8A),
                  ),
                  const SizedBox(height: 15),
                  PageViewTitles(
                      //model: mealModel,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
