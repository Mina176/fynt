import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/enums/category_type.dart';
import 'package:fynt/core/widgets/category_icon.dart';
import 'package:flutter/material.dart';

class CategoryIconWithLabel extends StatelessWidget {
  const CategoryIconWithLabel({super.key, required this.categoryType});

  final CategoryType categoryType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CategoryIcon(categoryType: categoryType),
        gapH4,
        Text(
          categoryType.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.subtitle.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
