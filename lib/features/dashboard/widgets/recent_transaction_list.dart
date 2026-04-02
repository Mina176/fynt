import 'package:fynt/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/widgets/empty_list_sliver_fill_remaining.dart';
import 'package:fynt/core/widgets/settings_section.dart';
import 'package:fynt/core/widgets/slidable_settings_tile.dart';
import 'package:fynt/features/transactions/logic/transaction_controller.dart';
import 'package:fynt/features/transactions/presentation/widgets/transaction_card.dart';

class RecentTransactionList extends ConsumerWidget {
  const RecentTransactionList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionControllerProvider);
    return transactionsAsync.when(
      skipLoadingOnReload: true,
      data: (allTransactions) {
        final recentTransactions = allTransactions.take(5).toList();
        if (allTransactions.isEmpty) {
          return const EmptyListSLiverFillRemaining(
            message: "Press the + button below to add a transaction.",
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
        child: Center(child: Text(context.l10n.somethingWentWrong)),
      ),
    );
  }
}
