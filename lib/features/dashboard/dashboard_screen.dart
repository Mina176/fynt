import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/features/accounts/logic/account_controller.dart';
import 'package:fynt/features/transactions/logic/transaction_controller.dart';
import 'package:fynt/features/settings/currency/logic/currency_provider.dart';
import 'package:fynt/features/dashboard/custom_app_bar.dart';
import 'package:fynt/core/widgets/custom_card.dart';
import 'package:fynt/core/widgets/last_month_container.dart';
import 'package:fynt/features/transactions/presentation/widgets/transaction_card.dart';
import 'package:fynt/features/analytics/weekly_spending_summary.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:fynt/core/widgets/settings_section.dart';
import 'package:fynt/core/widgets/slidable_settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionControllerProvider);
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
            horizontal: Sizes.kHorizontalPadding,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    const CustomAppBar(),
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
                                      savingPercentage:
                                          netWorthStats.percentChange,
                                    );
                            },
                            error: (error, stackTrace) =>
                                const SizedBox.shrink(),
                            loading: () => const Text(
                              '',
                              style: TextStyles.buttonLabel,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomCard(
                      child: weeklyDashboardAsync.when(
                        skipLoadingOnReload: true,
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
                                  const Spacer(),
                                  isFirstWeek.value ?? true
                                      ? const SizedBox.shrink()
                                      : LastMonthContainer(
                                          isShrinked: true,
                                          savingPercentage:
                                              weeklyDashboardData.percentChange,
                                        ),
                                ],
                              ),
                              const Divider(height: 12),
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Transactions',
                          style: TextStyles.header,
                        ),
                        GestureDetector(
                          onTap: () =>
                              context.push(AppRoutes.allTransactions.path),
                          child: const Text(
                            'View All',
                            style: TextStyles.headerLink,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              transactionsAsync.when(
                skipLoadingOnReload: true,
                data: (allTransactions) {
                  final recentTransactions = allTransactions.take(5).toList();
                  if (allTransactions.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: SizedBox(
                        height: 200,
                        child: Center(
                          child: Text(
                            "Press the + button below to add a transaction.",
                            textAlign: TextAlign.center,
                            style: TextStyles.hintText.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverToBoxAdapter(
                    child: SettingsSection(
                      widgets: List.generate(
                        recentTransactions.length,
                        (index) {
                          final transaction = recentTransactions[index];
                          return SlidableSettingsTile(
                            itemKey: ValueKey(recentTransactions[index].id),
                            onDeleteTapped: () => ref
                                .read(transactionControllerProvider.notifier)
                                .deleteTransaction(transaction.id),
                            child: TransactionCard(
                              transaction: transaction,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                loading: () => const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
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
