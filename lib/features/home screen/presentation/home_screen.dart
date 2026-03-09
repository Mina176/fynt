import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/features/accounts/logic/account_controller.dart';
import 'package:fintrack/features/add%20transaction/logic/transaction_controller.dart';
import 'package:fintrack/features/currency/logic/currency_provider.dart';
import 'package:fintrack/features/home%20screen/presentation/custom_app_bar.dart';
import 'package:fintrack/features/home%20screen/presentation/custom_card.dart';
import 'package:fintrack/features/home%20screen/presentation/last_month_container.dart';
import 'package:fintrack/features/home%20screen/presentation/transaction_card.dart';
import 'package:fintrack/features/home%20screen/presentation/weekly_spending_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(getTransactionsProvider);
    final weeklyDashboardAsync = ref.watch(getWeeklyDashboardDataProvider);
    final netWorthStatsAsync = ref.watch(netWorthStatsProvider);
    final currencySymbol = ref.watch(currencySymbolProvider);
    final isFirstMonth = ref.watch(isFirstMonthOfActivityProvider);
    final isFirstWeek = ref.watch(isFirstWeekOfActivityProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.kVerticalPadding,
            horizontal: Sizes.kHorizontalPadding,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    CustomAppBar(),
                    CustomCard(
                      child: Column(
                        spacing: 4,
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyles.subtitle.copyWith(fontSize: 14),
                          ),
                          Text(
                            netWorthStatsAsync.when(
                              data: (data) =>
                                  '$currencySymbol${data.currentBalance.toStringAsFixed(2)}',
                              error: (error, stackTrace) => 'Error',
                              loading: () => '${currencySymbol}0.00',
                            ),
                            style: TextStyles.title,
                          ),
                          netWorthStatsAsync.when(
                            data: (netWorthStats) => isFirstMonth.value!
                                ? SizedBox.shrink()
                                : LastMonthContainer(
                                    savingPercentage:
                                        netWorthStats.percentChange,
                                  ),
                            error: (error, stackTrace) => SizedBox.shrink(),
                            loading: () => Text(
                              '',
                              style: TextStyles.buttonLabel,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomCard(
                      child: weeklyDashboardAsync.when(
                        data: (weeklyDashboardData) {
                          final totalWeeklySpendings = weeklyDashboardData
                              .weeklySpendings
                              .fold(
                                0.0,
                                (sum, item) => sum + item,
                              );
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$currencySymbol${totalWeeklySpendings.toStringAsFixed(2)}',
                                        style: TextStyles.title.copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'Total spent this week',
                                        style: TextStyles.subtitle.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  isFirstWeek.value == null ||
                                          isFirstWeek.value!
                                      ? SizedBox.shrink()
                                      : LastMonthContainer(
                                          isShrinked: true,
                                          savingPercentage:
                                              weeklyDashboardData.percentChange,
                                        ),
                                ],
                              ),
                              Divider(height: 12),
                              gapH32,
                              WeeklySpendingSummary(
                                weeklySummary:
                                    weeklyDashboardData.weeklySpendings,
                              ),
                            ],
                          );
                        },
                        loading: () => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        error: (error, stackTrace) => Center(
                          child: Text('Error: $error'),
                        ),
                      ),
                    ),
                    Text('Recent Transactions', style: TextStyles.header),
                  ],
                ),
              ),
              transactionsAsync.when(
                data: (transactions) {
                  if (transactions.isEmpty) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 250,
                        child: Center(
                          child: Text(
                            "No transactions yet",
                            style: TextStyles.hintText.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverList.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      return TransactionCard(transaction: transactions[index]);
                    },
                  );
                },
                loading: () => const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 250,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
                error: (error, stack) => SliverToBoxAdapter(
                  child: Center(child: Text('Error: $error')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
