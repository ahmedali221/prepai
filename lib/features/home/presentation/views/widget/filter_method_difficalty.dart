import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Colors.dart';

class FilterMethodDifficalty extends StatefulWidget {
  const FilterMethodDifficalty({super.key});

  @override
  State<FilterMethodDifficalty> createState() => _FilterMethodDifficaltyState();
}

class _FilterMethodDifficaltyState extends State<FilterMethodDifficalty> {
  String selectedMeal = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 14,
          children: [
            "biggener",
            "medium",
            "cheff",
          ]
              .map(
                (difficalty) => ChoiceChip(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Text(difficalty),
                  ),
                  selected: selectedMeal == difficalty,
                  onSelected: (isSelected) {
                    setState(() {
                      selectedMeal = isSelected ? difficalty : "";
                    });
                  },
                  selectedColor: Color(0xff001A3F),
                  showCheckmark: false,
                  labelStyle: TextStyle(
                      fontSize: 18,
                      color: selectedMeal == difficalty
                          ? AppColors.unSelectedButtonBackgroundColor
                          : AppColors.c999999),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: selectedMeal == difficalty
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
