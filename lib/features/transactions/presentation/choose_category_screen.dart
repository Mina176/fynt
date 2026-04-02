import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/extensions/localization_extension.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fynt/core/enums/category_type.dart';
import 'package:fynt/features/transactions/presentation/widgets/category_icon_with_label.dart';

class ChooseCategoryScreen extends StatelessWidget {
  const ChooseCategoryScreen({
    super.key,
    required this.expenseOrIncome,
  });
  final int expenseOrIncome;

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
        title: Text(context.l10n.category),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.kVerticalPadding,
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseOrIncome == 0
                  ? context.l10n.spending
                  : context.l10n.income,
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
                itemCount: expenseOrIncome == 0
                    ? spendingCategories.length
                    : incomeCategories.length,
                itemBuilder: (context, index) {
                  final category = expenseOrIncome == 0
                      ? spendingCategories[index]
                      : incomeCategories[index];
                  return GestureDetector(
                    onTap: () => Navigator.pop(
                      context,
                      category,
                    ),
                    child: CategoryIconWithLabel(
                      categoryType: category,
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
