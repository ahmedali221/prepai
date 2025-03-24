import 'package:flutter/material.dart';
import 'package:prepai/features/Home/presentation/views/widget/filter_view_body.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FilterViewBody(),
    );
  }
}
