import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/widgets/custom_card.dart';
import 'package:fynt/core/widgets/last_month_container.dart';
import 'package:fynt/features/analytics/weekly_spending_summary.dart';
import 'package:fynt/features/settings/currency/currency_provider.dart';
import 'package:fynt/features/transactions/logic/transaction_controller.dart';

class WeeklyDashboard extends ConsumerWidget {
  const WeeklyDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyDashboardAsync = ref.watch(getWeeklyDashboardDataProvider);
    final isFirstWeek = ref.watch(isFirstWeekOfActivityProvider);
    return CustomCard(
      child: weeklyDashboardAsync.when(
        skipLoadingOnReload: true,
        data: (weeklyDashboardData) {
          final totalWeeklySpendings = weeklyDashboardData.weeklySpendings.fold(
            0.0,
            (sum, item) => sum + item,
          );
          return Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final currencySymbol = ref.watch(
                            currencySymbolProvider,
                          );
                          return Text(
                            '$currencySymbol${totalWeeklySpendings.toStringAsFixed(2)}',
                            style: TextStyles.title.copyWith(
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                      Text(
                        'Total spent this week',
                        style: TextStyles.subtitle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  isFirstWeek.value ?? true
                      ? const SizedBox.shrink()
                      : LastMonthContainer(
                          isShrinked: true,
                          savingPercentage: weeklyDashboardData.percentChange,
                        ),
                ],
              ),
              const Divider(height: 12),
              gapH32,
              WeeklySpendingSummary(
                weeklySummary: weeklyDashboardData.weeklySpendings,
              ),
            ],
          );
        },
        loading: () => SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (error, stackTrace) => const Center(
          child: Text(
            'Something went wrong. Please try again.',
          ),
        ),
      ),
    );
  }
}
