import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/enums/category_type.dart';
import 'package:fynt/core/theming/app_colors.dart';
import 'package:fynt/core/utils/category_style.dart';
import 'package:fynt/features/settings/appearance/logic/theme_controller.dart';

class SelectCategoryListviewItem extends ConsumerWidget {
  const SelectCategoryListviewItem({
    super.key,
    required this.isSelected,
    required this.categoryType,
    required this.onTap,
  });
  final bool isSelected;
  final CategoryType categoryType;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = getCategoryStyle(
      categoryType,
      ref.watch(themeControllerProvider),
    );
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.kPrimaryColor
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                style.icon,
                color: isSelected ? Colors.black : null,
              ),
              gapW4,
              Text(
                categoryType.name,
                style: TextStyle(
                  color: isSelected ? Colors.black : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
