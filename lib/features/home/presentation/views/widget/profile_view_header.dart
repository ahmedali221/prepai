import 'package:flutter/material.dart';
import '../../../../../Core/theme/app_colors.dart';


class ProfileViewHeader extends StatelessWidget {
  const ProfileViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu, color: AppColors.c001A3F),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: AppColors.c001A3F),
        ),
      ],
    );
  }
}
