import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/widgets/last_month_container.dart';
import 'package:fynt/features/accounts/logic/account_controller.dart';
import 'package:fynt/features/settings/currency/logic/currency_provider.dart';
import 'package:fynt/features/transactions/logic/transaction_controller.dart';

class BalanceWithLastMonthContainer extends ConsumerWidget {
  const BalanceWithLastMonthContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final netWorthAsync = ref.watch(getNetWorthProvider);
    final currencySymbol = ref.watch(currencySymbolProvider);
    final isFirstMonth =
        ref.watch(isFirstMonthOfActivityProvider).value ?? true;
    final weeklyDashboard = ref.watch(getWeeklyDashboardDataProvider).value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          netWorthAsync.when(
            data: (data) => '$currencySymbol${data.toStringAsFixed(2)}',
            error: (error, stackTrace) => 'Error',
            loading: () => '${currencySymbol}0.00',
          ),
          style: TextStyles.title,
          textAlign: TextAlign.center,
        ),
        gapW4,
        isFirstMonth || weeklyDashboard == null
            ? const SizedBox.shrink()
            : LastMonthContainer(
                savingPercentage: weeklyDashboard.percentChange,
                isShrinked: true,
              ),
      ],
    );
  }
}
