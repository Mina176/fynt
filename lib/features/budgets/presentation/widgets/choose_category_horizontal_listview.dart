import 'package:flutter/material.dart';
import 'package:fynt/core/enums/category_type.dart';
import 'package:fynt/features/budgets/presentation/add_budget_screen.dart';
import 'package:fynt/features/budgets/presentation/widgets/select_category_listview_item.dart';

class ChooseCategoryHorizontalListView extends StatelessWidget {
  const ChooseCategoryHorizontalListView({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });
  final CategoryType selectedCategory;
  final ValueChanged<CategoryType> onCategorySelected;
  @override
  Widget build(BuildContext context) {
    final spendingCategories = CategoryType.values
        .where((c) => !c.isIncome)
        .toList();
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: spendingCategories.length,
        itemBuilder: (context, index) {
          final categoryType = spendingCategories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: SelectCategoryListviewItem(
              categoryType: categoryType,
              isSelected: selectedCategory == categoryType,
              onTap: () => onCategorySelected(categoryType),
            ),
          );
        },
      ),
    );
  }
}
