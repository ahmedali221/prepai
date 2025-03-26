import 'package:flutter/material.dart';
import 'package:prepai/features/Meals/presentation/views/widget/page_view_title_item.dart';
import 'package:prepai/features/Meals/presentation/views/widget/summary_view.dart';
import '../../../domain/entities/meal_entity.dart';
import 'direction_view.dart';
import 'ingredients_view.dart';

class PageViewTitles extends StatefulWidget {
  const PageViewTitles({
    super.key,
    required this.mealModel,
  });

  final Meal mealModel;

  @override
  State<PageViewTitles> createState() => _PageViewTitlesState();
}

class _PageViewTitlesState extends State<PageViewTitles> {
  late final List<String> titles;
  late final List<Widget> pages;
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = 0;
    titles = [
      "Summary",
      "Ingredients",
      "Direction",
    ];
    pages = [
      SummaryView(mealModel: widget.mealModel),
      IngredientsView(mealModel: widget.mealModel),
      DirectionView(mealModel: widget.mealModel)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PageViewTitleItem(
                title: titles[0],
                isSelected: selectedIndex == 0,
                onTap: () {
                  selectedIndex = 0;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: PageViewTitleItem(
                title: titles[1],
                isSelected: selectedIndex == 1,
                onTap: () {
                  selectedIndex = 1;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: PageViewTitleItem(
                title: titles[2],
                isSelected: selectedIndex == 2,
                onTap: () {
                  selectedIndex = 2;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10),
        pages[selectedIndex],
      ],
    );
  }
}
