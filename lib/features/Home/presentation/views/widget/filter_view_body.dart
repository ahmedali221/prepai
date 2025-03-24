import 'package:flutter/material.dart';
import 'package:prepai/features/Home/presentation/views/widget/filter_header.dart';

class FilterViewBody extends StatelessWidget {
  const FilterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 36),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterHeader(),
          ],
        ),
      ),
    );
  }
}
