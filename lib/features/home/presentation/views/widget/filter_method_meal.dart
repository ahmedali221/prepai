import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Colors.dart';

class FilterMethodMeal extends StatefulWidget {
  const FilterMethodMeal({super.key});

  @override
  State<FilterMethodMeal> createState() => FilterMethodMealState();
}

class FilterMethodMealState extends State<FilterMethodMeal> {
  String? selectedMeal;
  String? getMealType() {
    return selectedMeal;
  }

  void reset() {
    setState(() {
      selectedMeal = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 14,
          runSpacing: 16,
          children:
              ["Breakfast", "Lunch", "Dinner", "Drink", "Dessert", "Snacks"]
                  .map((meal) => ChoiceChip(
                        label: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 7),
                          child: Text(meal),
                        ),
                        selected: selectedMeal == meal,
                        onSelected: (isSelected) {
                          setState(() {
                            selectedMeal = isSelected ? meal : "";
                          });
                        },
                        selectedColor: AppColors.c001A3F,
                        showCheckmark: false,
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: selectedMeal == meal
                                ? AppColors.unSelectedButtonBackgroundColor
                                : AppColors.c999999),
                      ))
                  .toList(),
        ),
      ],
    );
  }
}
