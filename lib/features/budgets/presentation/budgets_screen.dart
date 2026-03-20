// ignore_for_file: deprecated_member_use

import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/enums/recurrence_type.dart';
import 'package:fynt/core/widgets/app_bar_action.dart';
import 'package:fynt/features/budgets/logic/budget_controller.dart';
import 'package:fynt/features/budgets/presentation/widgets/budget_sliver_list.dart';
import 'package:fynt/features/budgets/presentation/widgets/choose_period_horizontal_list_view.dart';
import 'package:fynt/features/budgets/presentation/widgets/left_to_spend_section.dart';
import 'package:fynt/features/settings/currency/currency_provider.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:fynt/core/theming/app_colors.dart';
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
        actions: const [
          AppBarAction(appRoute: AppRoutes.addBudget),
          gapW20,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.kVerticalPadding,
          horizontal: Sizes.kHorizontalPadding,
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
                  LeftToSpendSection(
                    currencySymbol: currencySymbol,
                    spendLimit: spendLimit,
                    spentAmount: spentAmount,
                  ),
                  const Text('Categories', style: TextStyles.header),
                  gapH4,
                ],
              ),
            ),
            BudgetSliverList(
              selectedPeriod: selectedPeriod,
              currencySymbol: currencySymbol,
            ),
          ],
        ),
      ),
    );
  }
}
