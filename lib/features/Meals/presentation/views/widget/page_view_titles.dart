import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/presentation/views/widget/page_view_title_item.dart';
import 'package:prepai/features/Meals/presentation/views/widget/summary_view.dart';

import 'direction_view.dart';
import 'ingredients_view.dart';

final pageIndexProvider = StateProvider<int>((ref) => 0);

class PageViewTitles extends ConsumerWidget{
  const PageViewTitles({super.key, required this.mealId});

  final String mealId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(pageIndexProvider);

    final titles = ["Summary", "Ingredients", "Direction"];
    final pages = [
      SummaryView(mealId: mealId),
      IngredientsView(mealId: mealId),
      DirectionView(mealId: mealId),
    ];

    return Column(
      children: [
        Row(
          children: List.generate(titles.length, (index) {
            return Expanded(
              child: PageViewTitleItem(
                title: titles[index],
                index: index,
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        pages[selectedIndex],
      ],
    );
  }
}
