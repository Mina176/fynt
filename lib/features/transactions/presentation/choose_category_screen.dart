import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fynt/core/enums/category_type.dart';
import 'package:fynt/features/transactions/presentation/widgets/category_icon_with_label.dart';

class ChooseCategoryScreen extends StatelessWidget {
  const ChooseCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spendingCategories = CategoryType.values
        .where((c) => !c.isIncome)
        .toList();
    final incomeCategories = CategoryType.values
        .where((c) => c.isIncome)
        .toList();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text('Choose Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending',
              style: TextStyles.subtitle.copyWith(fontSize: 14),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.kHorizontalPadding,
                  vertical: Sizes.kVerticalPadding,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 70,
                  mainAxisSpacing: Sizes.kVerticalPadding,
                  crossAxisSpacing: Sizes.kHorizontalPadding,
                ),
                itemCount: spendingCategories.length,
                itemBuilder: (context, index) {
                  final spendingCategory = spendingCategories[index];
                  return GestureDetector(
                    onTap: () => Navigator.pop(
                      context,
                      spendingCategory,
                    ),
                    child: CategoryIconWithLabel(
                      categoryType: spendingCategory,
                    ),
                  );
                },
              ),
            ),
            Text(
              'Income',
              style: TextStyles.subtitle.copyWith(fontSize: 14),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.kHorizontalPadding,
                  vertical: Sizes.kVerticalPadding,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 70,
                  mainAxisSpacing: Sizes.kVerticalPadding,
                  crossAxisSpacing: Sizes.kHorizontalPadding,
                ),
                itemCount: incomeCategories.length,
                itemBuilder: (context, index) {
                  final incomeCategory = incomeCategories[index];
                  return GestureDetector(
                    onTap: () => Navigator.pop(
                      context,
                      incomeCategory,
                    ),
                    child: CategoryIconWithLabel(
                      categoryType: incomeCategory,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
