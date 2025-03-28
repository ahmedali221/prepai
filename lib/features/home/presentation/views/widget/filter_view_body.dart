import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/theme/App_Colors.dart';
import 'package:prepai/Core/theme/App_Styles.dart';
import 'package:prepai/Core/utils/constants.dart';
import 'package:prepai/features/home/presentation/controllers/meals_riverpod/Riverpod/Meal_Provider.dart';
import 'package:prepai/features/home/presentation/views/widget/filter_header.dart';
import 'package:prepai/features/home/presentation/views/widget/filter_method_meal.dart';
import 'package:prepai/features/home/presentation/views/widget/filter_method_time.dart';



class FilterViewBody extends ConsumerStatefulWidget {
  const FilterViewBody({super.key});

  @override
  ConsumerState<FilterViewBody> createState() => _FilterViewBodyState();
}

class _FilterViewBodyState extends ConsumerState<FilterViewBody> {
  final GlobalKey<FilterMethodTimeState> timeKey = GlobalKey();
  final GlobalKey<FilterMethodMealState> mealTypeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 36),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: SingleChildScrollView(
          child: Column(
            spacing: 25,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterHeader(
                onTap: () {
                  timeKey.currentState?.reset();

                  mealTypeKey.currentState?.reset();
                },
              ),
              Text(
                AppConsts.meal,
                style: AppStyles.textStyleBold20,
              ),
              FilterMethodMeal(
                key: mealTypeKey,
              ),
              Text(
                AppConsts.time,
                style: AppStyles.textStyleBold20,
              ),
              FilterMethodTime(
                key: timeKey,
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      final selectedTime = timeKey.currentState?.getTime();
                      final selectedMealType =
                          mealTypeKey.currentState?.getMealType();

                      ref.read(mealProvider.notifier).fetchData(
                          mealPreparationTime: selectedTime,
                          mealType: selectedMealType);
                      ref.read(isFilteredProvider.notifier).state = true;
                      if (selectedTime != null || selectedMealType != null) {
                        ref.read(isFilteredProvider.notifier).state = true;
                      }

                      Navigator.pop(context);
                    },
                    child: Text(
                      'Search',
                      style: AppStyles.textStyleBold20
                          .copyWith(color: AppColors.cFFFFFF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
