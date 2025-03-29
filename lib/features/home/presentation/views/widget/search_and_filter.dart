import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Home/presentation/views/screen/filter_screen.dart';
import 'package:prepai/features/home/presentation/controllers/meals_riverpod/Riverpod/Meal_Provider.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../../../Core/utils/assets.dart';
import '../../../../../Core/utils/constants.dart';

class SearchAndFilter extends ConsumerStatefulWidget {
  const SearchAndFilter({super.key});

  @override
  ConsumerState<SearchAndFilter> createState() => _SearchAndFilterState();
}

class _SearchAndFilterState extends ConsumerState<SearchAndFilter> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.c999999,
                  blurRadius: 7,
                  spreadRadius: 4,
                  offset: const Offset(4, 5),
                ),
              ],
              color: Colors.white,
            ),
            child: TextFormField(
              onChanged: (value) {
                ref.read(mealProvider.notifier).fetchData(mealName: value);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: AppColors.cFFFFFF,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => const FilterScreen(),
                    );
                  },
                  icon: Image.asset(
                    AppAssets.maskGroupIcon,
                  ),
                ),
                hintText: AppConsts.searchrecipes,
                hintStyle: TextStyle(
                  color: AppColors.c939393,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
      ],
    );
  }
}

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                AppConsts.filter,
                style: AppStyles.textStyle21.copyWith(color: AppColors.c001A3F),
              ),
              const Spacer(),
              Text(
                AppConsts.reset,
                style: AppStyles.textStyle18.copyWith(color: AppColors.c0047FF),
              ),
            ],
          ),
          Text(
            AppConsts.meal,
            style: AppStyles.textStyle20.copyWith(color: AppColors.c001A3F),
          ),
          SizedBox(
            height: screenHeight * 0.05,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text("Name of -  "),
                  ),
                );
              },
            ),
          ),
          Text(
            AppConsts.time,
            style: AppStyles.textStyle20.copyWith(color: AppColors.c001A3F),
          ),
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.05,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text('Name of -'),
                  ),
                );
              },
            ),
          ),
          Text(
            AppConsts.diffeculty,
            style: AppStyles.textStyle20.copyWith(color: AppColors.c001A3F),
          ),
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.05,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text("Name of -"),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Text(
                AppConsts.numofindredients,
                style: AppStyles.textStyle21.copyWith(color: AppColors.c001A3F),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text("5"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
