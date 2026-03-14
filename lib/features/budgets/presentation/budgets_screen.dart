import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/utils/helpers.dart';
import 'package:fintrack/features/budgets/data/budget_model.dart';
import 'package:fintrack/features/budgets/logic/budget_controller.dart';
import 'package:fintrack/features/budgets/presentation/left_to_spend_card.dart';
import 'package:fintrack/features/currency/logic/currency_provider.dart';
import 'package:fintrack/routing/app_route_enum.dart';
import 'package:fintrack/theming/app_colors.dart';
import 'package:fintrack/widgets/category_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BudgetsScreen extends ConsumerStatefulWidget {
  const BudgetsScreen({super.key});

  @override
  ConsumerState<BudgetsScreen> createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends ConsumerState<BudgetsScreen> {
  RecurrenceDuration selectedPeriod = RecurrenceDuration.weekly;

  @override
  Widget build(BuildContext context) {
    final budgetsAsync = ref.watch(getBudgetsProvider(selectedPeriod));
    final budgetsDetails = ref.watch(
      getAllBudgetsDetailsProvider(selectedPeriod),
    );
    final currencySymbol = ref.watch(currencySymbolProvider);
    final double spendLimit = budgetsDetails.value?.totalLimit ?? 0.0;
    final double spentAmount = budgetsDetails.value?.totalSpent ?? 0.0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('My budgets'),
        actions: [
          DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: GestureDetector(
                onTap: () => context.push(AppRoutes.addBudget.path),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          gapW20,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kHorizontalPadding,
          vertical: Sizes.kVerticalPadding,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChoosePeriodHorizontalListView(
                    selectedPeriod: selectedPeriod,
                    onPeriodSelected: (period) {
                      setState(() {
                        selectedPeriod = period;
                      });
                    },
                  ),
                  LeftToSpendCard(
                    leading: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'LEFT TO SPEND',
                              style: TextStyles.headerLink,
                            ),
                            Text(
                              '$currencySymbol${spendLimit == 0 ? 0 : (spendLimit - spentAmount).round()}',
                              style: TextStyles.header.copyWith(fontSize: 32),
                            ),
                          ],
                        ),
                        Text(
                          '${spendLimit == 0 ? 0 : (spentAmount * 100 / spendLimit).round()}%',
                          style: TextStyles.title.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    spentAmount: spentAmount,
                    spendLimit: spendLimit,
                  ),
                  const Text('Categories', style: TextStyles.header),
                  gapH4,
                ],
              ),
            ),
            budgetsAsync.when(
              data: (budgets) => budgets.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: Text(
                          "Press the + button above to add a budget.",
                          textAlign: TextAlign.center,
                          style: TextStyles.hintText.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : SliverList.separated(
                      itemCount: budgets.length,
                      separatorBuilder: (context, index) => gapH12,
                      itemBuilder: (context, index) {
                        final budget = budgets[index];
                        final safeBudgetLimit = budget.limit == 0
                            ? 1
                            : budget.limit;
                        return LeftToSpendCard(
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
                                    getCategoryName(
                                      budget.category,
                                    ),
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
                                style: TextStyles.title.copyWith(fontSize: 14),
                              ),
                            ],
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
            ),
          ],
        ),
      ),
    );
  }
}

class ChoosePeriodHorizontalListView extends StatelessWidget {
  const ChoosePeriodHorizontalListView({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });
  final RecurrenceDuration selectedPeriod;
  final ValueChanged<RecurrenceDuration> onPeriodSelected;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        children: List.generate(
          RecurrenceDuration.values.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoosePeriodHorizontalListViewItem(
              isSelected: selectedPeriod == RecurrenceDuration.values[index],
              period: RecurrenceDuration.values[index],
              onTap: () {
                onPeriodSelected(RecurrenceDuration.values[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ChoosePeriodHorizontalListViewItem extends StatelessWidget {
  const ChoosePeriodHorizontalListViewItem({
    super.key,
    required this.isSelected,
    required this.period,
    required this.onTap,
  });
  final bool isSelected;
  final RecurrenceDuration period;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.kPrimaryColor
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.kPrimaryColor.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Center(
            child: Text(
              period.name.toUpperCase()[0] + period.name.substring(1),
              style: TextStyles.title.copyWith(
                fontSize: 12,
                color: isSelected ? Colors.black : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
