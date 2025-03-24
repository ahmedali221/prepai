import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Colors.dart';

class FilterMethodNumber extends StatefulWidget {
  const FilterMethodNumber({super.key});

  @override
  State<FilterMethodNumber> createState() => _FilterMethodNumberState();
}

class _FilterMethodNumberState extends State<FilterMethodNumber> {
  String selectedMeal = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 14,
          children: [
            "5",
          ]
              .map(
                (num) => ChoiceChip(
                  label: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                    child: Text(num),
                  ),
                  selected: selectedMeal == num,
                  onSelected: (isSelected) {
                    setState(() {
                      selectedMeal = isSelected ? num : "";
                    });
                  },
                  selectedColor: Color(0xff001A3F),
                  showCheckmark: false,
                  labelStyle: TextStyle(
                      fontSize: 18,
                      color: selectedMeal == num
                          ? AppColors.UnSelectedButtonBackgroundColor
                          : AppColors.c999999),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: selectedMeal == num
                          ? Colors.transparent
                          : AppColors.c999999,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
