import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Colors.dart';

class FilterMethodTime extends StatefulWidget {
  const FilterMethodTime({super.key});

  @override
  State<FilterMethodTime> createState() => _FilterMethodTimeState();
}

class _FilterMethodTimeState extends State<FilterMethodTime> {
  String selectedMeal = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 14,
          children: [
            "5min",
            "10min",
            "15min",
          ]
              .map(
                (time) => ChoiceChip(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Text(time),
                  ),
                  selected: selectedMeal == time,
                  onSelected: (isSelected) {
                    setState(() {
                      selectedMeal = isSelected ? time : "";
                    });
                  },
                  selectedColor: Color(0xff001A3F),
                  showCheckmark: false,
                  labelStyle: TextStyle(
                      fontSize: 18,
                      color: selectedMeal == time
                          ? AppColors.unSelectedButtonBackgroundColor
                          : AppColors.c999999),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                    side: BorderSide(
                      color: selectedMeal == time
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
