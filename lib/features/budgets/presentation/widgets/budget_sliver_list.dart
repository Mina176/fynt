import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/enums/recurrence_type.dart';
import 'package:fynt/core/widgets/category_icon.dart';
import 'package:fynt/core/widgets/empty_list_sliver_fill_remaining.dart';
import 'package:fynt/core/widgets/slidable_settings_tile.dart';
import 'package:fynt/features/budgets/logic/budget_controller.dart';
import 'package:fynt/features/budgets/presentation/widgets/left_to_spend_card.dart';

class BudgetSliverList extends ConsumerWidget {
  const BudgetSliverList({
    super.key,
    required this.selectedPeriod,
    required this.currencySymbol,
  });

  final RecurrenceDuration selectedPeriod;
  final String currencySymbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetsAsync = ref.watch(budgetControllerProvider(selectedPeriod));
    return budgetsAsync.when(
      data: (budgets) => budgets.isEmpty
          ? const EmptyListSLiverFillRemaining(
              message: 'Press the + button above to add a budget.',
            )
          : SliverList.separated(
              itemCount: budgets.length,
              separatorBuilder: (context, index) => gapH12,
              itemBuilder: (context, index) {
                final budget = budgets[index];
                final safeBudgetLimit = budget.limit == 0 ? 1 : budget.limit;
                return SlidableSettingsTile(
                  itemKey: ValueKey(budgets[index].id),
                  onDeleteTapped: () => ref
                      .read(
                        budgetControllerProvider(
                          selectedPeriod,
                        ).notifier,
                      )
                      .deleteBudget(budget.id),
                  child: LeftToSpendCard(
                    spendLimit: budget.limit,
                    spentAmount: budget.spent,
                    leading: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CategoryIcon(
                          categoryType: budget.category,
                        ),
                        gapW8,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              budget.category.label,
                              style: TextStyles.title.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            gapH4,
                            Text(
                              '$currencySymbol${(budget.limit - budget.spent).round()} remaining',
                              style: TextStyles.subtitle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '${(budget.spent * 100 / safeBudgetLimit).round()}%',
                          style: TextStyles.title.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      loading: () => const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => const SliverFillRemaining(
        child: Center(
          child: Text('Error loading budgets'),
        ),
      ),
    );
  }
}
