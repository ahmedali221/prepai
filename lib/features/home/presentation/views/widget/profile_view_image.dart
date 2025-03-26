import 'package:flutter/material.dart';
import '../../../../../Core/theme/App_Colors.dart';
import '../../../../../Core/utils/assets.dart';

class ProfileViewImage extends StatelessWidget {
  const ProfileViewImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: Image.network(
                '',
                fit: BoxFit.contain,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                        color: AppColors.c001A3F,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object object, StackTrace? stackTrace) {
                  return const Placeholder();
                },
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.c001A3F,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      AppAssets.editIcon,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
