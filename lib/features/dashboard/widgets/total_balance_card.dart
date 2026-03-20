import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/widgets/custom_card.dart';
import 'package:fynt/core/widgets/last_month_container.dart';
import 'package:fynt/features/accounts/logic/account_controller.dart';
import 'package:fynt/features/settings/currency/currency_provider.dart';
import 'package:fynt/features/transactions/logic/transaction_controller.dart';

class TotalBalanceCard extends ConsumerWidget {
  const TotalBalanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final netWorthStatsAsync = ref.watch(netWorthStatsProvider);
    final currencySymbol = ref.watch(currencySymbolProvider);
    final isFirstMonth = ref.watch(isFirstMonthOfActivityProvider);
    return CustomCard(
      child: Column(
        spacing: 4,
        children: [
          Text(
            'Total Balance',
            style: TextStyles.subtitle.copyWith(fontSize: 14),
          ),
          Text(
            netWorthStatsAsync.when(
              skipLoadingOnReload: true,
              data: (data) =>
                  '$currencySymbol${data.currentBalance.toStringAsFixed(2)}',
              error: (error, stackTrace) =>
                  'Something went wrong. Please try again.',
              loading: () => '${currencySymbol}0.00',
            ),
            style: TextStyles.title,
          ),
          netWorthStatsAsync.when(
            skipLoadingOnReload: true,
            data: (netWorthStats) {
              final firstMonth = isFirstMonth.value ?? true;
              if (firstMonth) return const SizedBox.shrink();
              return isFirstMonth.value!
                  ? const SizedBox.shrink()
                  : LastMonthContainer(
                      savingPercentage: netWorthStats.percentChange,
                    );
            },
            error: (error, stackTrace) => const SizedBox.shrink(),
            loading: () => const Text(
              '',
              style: TextStyles.buttonLabel,
            ),
          ),
        ],
      ),
    );
  }
}
