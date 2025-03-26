import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/presentation/Riverpod/Meal_Provider.dart';
import 'package:prepai/features/Meals/presentation/Riverpod/Meal_State.dart';
import '../../../../../Core/theme/App_Colors.dart';
import '../../../../../Core/theme/App_Styles.dart';

class RecipesBuilder extends ConsumerStatefulWidget {
  const RecipesBuilder({super.key});

  @override
  ConsumerState<RecipesBuilder> createState() => _RecipesBuilderState();
}

class _RecipesBuilderState extends ConsumerState<RecipesBuilder> {
  @override
  Widget build(BuildContext context) {
    final mealState = ref.watch(mealProvider);
    return mealState.status == MealStatus.loading
        ? CircularProgressIndicator()
        : mealState.Meal!.fold(
            (errorMessage) => Text(
                  errorMessage,
                  style:
                      AppStyles.textStyle14.copyWith(color: AppColors.c8A8A8A),
                ),
            (meals) => meals.isEmpty
                ? Text(
                    'No meals available',
                    style: AppStyles.textStyle14
                        .copyWith(color: AppColors.c8A8A8A),
                  )
                : ListView.builder(itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Card(
                          elevation: 4,
                          shadowColor: Colors.grey.withValues(alpha: 0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  //backgroundImage: image,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        meals[index].mealTextSummary,
                                        style: AppStyles.textStyle14
                                            .copyWith(color: AppColors.c001A3F),
                                      ),
                                      Text(
                                        meals[index].mealName,
                                        style: AppStyles.textStyle20
                                            .copyWith(color: AppColors.c000000),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            meals[index]
                                                .mealIngredients
                                                .toString(),
                                            style: AppStyles.textStyle14
                                                .copyWith(
                                                    color: AppColors.c8A8A8A),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            meals[index]
                                                .mealPreparationTime
                                                .toString(),
                                            style: AppStyles.textStyle14
                                                .copyWith(
                                                    color: AppColors.c001A3F),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: List.generate(5, (index) {
                                          return Icon(
                                            Icons.star,
                                            size: 20,
                                            color: Colors.yellow[700],
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: AppColors.c001A3F,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }));
  }
}
