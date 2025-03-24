import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Styles.dart';
import 'package:prepai/Core/utils/constants.dart';
import 'package:prepai/features/Home/presentation/views/widget/filter_header.dart';
import 'package:prepai/features/Home/presentation/views/widget/filter_method_difficalty.dart';
import 'package:prepai/features/Home/presentation/views/widget/filter_method_meal.dart';
import 'package:prepai/features/Home/presentation/views/widget/filter_method_time.dart';

class FilterViewBody extends StatelessWidget {
  const FilterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 36),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterHeader(),
            SizedBox(
              height: 35,
            ),
            Text(
              AppConsts.meal,
              style: AppStyles.textStyleBold20,
            ),
            SizedBox(
              height: 14,
            ),
            FilterMethodMeal(),
            SizedBox(
              height: 27,
            ),
            Text(
              AppConsts.time,
              style: AppStyles.textStyleBold20,
            ),
            SizedBox(
              height: 14,
            ),
            FilterMethodTime(),
            SizedBox(
              height: 27,
            ),
            Text(
              AppConsts.diffeculty,
              style: AppStyles.textStyleBold20,
            ),
            SizedBox(
              height: 14,
            ),
            FilterMethodDifficalty(),
          ],
        ),
      ),
    );
  }
}
