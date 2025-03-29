import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/presentation/views/widget/page_view_titles.dart';
import '../../../../../Core/theme/app_styles.dart';
import '../../../../../Core/theme/app_colors.dart';

class PageViewTitleItem extends ConsumerWidget {
  const PageViewTitleItem({
    super.key,
    required this.title,
    required this.index,
  });

  final String title;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(pageIndexProvider);

    return GestureDetector(
      onTap: () => ref.read(pageIndexProvider.notifier).state = index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppStyles.textStyle20.copyWith(
              color: selectedIndex == index ? AppColors.c001A3F : AppColors.c8A8A8A,
            ),
          ),
          const SizedBox(height: 7),
          selectedIndex == index
              ? Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.c001A3F,
                    borderRadius: BorderRadius.circular(50),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
