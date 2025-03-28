import 'package:flutter/material.dart';
import 'package:prepai/Core/theme/App_Colors.dart';

class FilterMethodTime extends StatefulWidget {
  const FilterMethodTime({super.key});

  @override
  State<FilterMethodTime> createState() => FilterMethodTimeState();
}

class FilterMethodTimeState extends State<FilterMethodTime> {
  int? selectedTime;

  int? getTime() {
    return selectedTime;
  }

  void reset() {
    setState(() {
      selectedTime = null;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
        Wrap(
          spacing: 14,
          children: [
            5,
            10,
            14,
          ]
              .map(
                (time) => ChoiceChip(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Text('$time'),
                  ),
                  selected: selectedTime == time,
                  onSelected: (isSelected) {
                    setState(() {
                      selectedTime = isSelected ? time : 0;
                    });
                  },
                  selectedColor: Color(0xff001A3F),
                  showCheckmark: false,
                  labelStyle: TextStyle(
                      fontSize: 18,
                      color: selectedTime == time
                          ? AppColors.unSelectedButtonBackgroundColor
                          : AppColors.c999999),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                    side: BorderSide(
                      color: selectedTime == time
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
