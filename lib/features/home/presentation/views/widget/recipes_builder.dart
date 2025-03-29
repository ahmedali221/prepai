import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/Core/Routes/App_Routes.dart';

import 'package:prepai/features/home/presentation/controllers/meals_riverpod/Riverpod/Meal_Provider.dart';
import 'package:prepai/features/home/presentation/controllers/meals_riverpod/Riverpod/Meal_State.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../../../Core/theme/app_styles.dart';

class RecipesBuilder extends ConsumerStatefulWidget {
  const RecipesBuilder({super.key});

  @override
  ConsumerState<RecipesBuilder> createState() => _RecipesBuilderState();
}

class _RecipesBuilderState extends ConsumerState<RecipesBuilder> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(mealProvider.notifier).fetchData());
  }

  @override
  Widget build(BuildContext context) {
    final mealState = ref.watch(mealProvider);
    final selectedTimeProvider = StateProvider<int?>((ref) => null);
    final selectedTime = ref.watch(selectedTimeProvider);

    return mealState.status == MealStatus.loading
        ? Center(child: CircularProgressIndicator())
        : mealState.meal == null
            ? Center(
                child: Text(
                  'No meals available',
                  style:
                      AppStyles.textStyle14.copyWith(color: AppColors.c8A8A8A),
                ),
              )
            : mealState.meal!.fold(
                (errorMessage) => Text(
                      errorMessage,
                      style: AppStyles.textStyle14
                          .copyWith(color: AppColors.c8A8A8A),
                    ),
                (meals) => meals.isEmpty
                    ? Text(
                        'No meals available',
                        style: AppStyles.textStyle14
                            .copyWith(color: AppColors.c8A8A8A),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: meals.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.go("${AppRouter.kMealDetails}/kofta");
                            },
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
                                              meals[index].textSummary,
                                              style: AppStyles.textStyle14
                                                  .copyWith(
                                                      color: AppColors.c001A3F),
                                            ),
                                            Text(
                                              meals[index].name,
                                              style: AppStyles.textStyle20
                                                  .copyWith(
                                                      color: AppColors.c000000),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Text(
                                                  meals[index]
                                                      .ingredients
                                                      .toString(),
                                                  style: AppStyles.textStyle14
                                                      .copyWith(
                                                          color: AppColors
                                                              .c8A8A8A),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  meals[index]
                                                      .preparationTime
                                                      .toString(),
                                                  style: AppStyles.textStyle14
                                                      .copyWith(
                                                          color: AppColors
                                                              .c001A3F),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children:
                                                  List.generate(5, (index) {
                                                return Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: Colors.yellow[700],
                                                );
                                              }),
                                            ),
                                            if (selectedTime != null)
                                              Text('time')
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          true
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: true
                                              ? Colors.red
                                              : AppColors.c001A3F,
                                        ),
                                        onPressed: () {
                                          // setState(() {
                                          //   meals[index].isFavourite =
                                          //       !meals[index].isFavourite;

                                          //   if (meals[index].isFavourite) {
                                          //   } else {}
                                          // });
                                          // meals[index].isFavourite;
                                        },
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
