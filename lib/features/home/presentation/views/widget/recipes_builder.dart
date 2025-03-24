import 'package:flutter/material.dart';
import '../../../../../Core/theme/App_Colors.dart';
import '../../../../../Core/theme/App_Styles.dart';

class RecipesBuilder extends StatelessWidget {
  const RecipesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Card(
          elevation: 4,
          shadowColor: Colors.grey.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  //backgroundImage: image,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No subtitle',
                        style: AppStyles.textStyle14.copyWith(color: AppColors.c001A3F),
                      ),
                      Text(
                        'No name',
                        style: AppStyles.textStyle20.copyWith(color: AppColors.c000000),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '12 ingredients',
                            style: AppStyles.textStyle14.copyWith(color: AppColors.c8A8A8A),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '30 min',
                            style: AppStyles.textStyle14.copyWith(color: AppColors.c001A3F),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.yellow[700],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    color: AppColors.c001A3F,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
