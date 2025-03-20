import 'package:flutter/material.dart';
import '../../../../../Core/theme/App_Colors.dart';

class SideBarAndNotifications extends StatelessWidget {
  const SideBarAndNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(
            Icons.menu,
            color: AppColors.c001A3F,
            size: 30,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            color: AppColors.c001A3F,
            size: 30,
          ),
        ),
      ],
    );
  }
}
