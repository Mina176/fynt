import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/features/transactions/logic/transaction_controller.dart';
import 'package:fynt/features/transactions/presentation/widgets/transaction_card.dart';
import 'package:fynt/core/widgets/settings_section.dart';
import 'package:fynt/core/widgets/slidable_settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllTransactionsScreen extends ConsumerWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Transactions",
          style: TextStyles.title.copyWith(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: transactionsAsync.when(
          data: (transactions) {
            if (transactions.isEmpty) {
              return Center(
                child: Text(
                  'No transactions yet. Start by adding your first transaction!',
                  textAlign: TextAlign.center,
                  style: TextStyles.subtitle.copyWith(
                    color: Colors.grey,
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: SettingsSection(
                widgets: List.generate(
                  transactions.length,
                  (index) {
                    final transaction = transactions[index];
                    return SlidableSettingsTile(
                      itemKey: ValueKey(transactions[index].id),
                      onDeleteTapped: () {
                        ref
                            .read(transactionControllerProvider.notifier)
                            .deleteTransaction(transaction.id);
                      },
                      child: TransactionCard(
                        transaction: transaction,
                      ),
                    );
                  },
                ),
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => const Center(
            child: Text('Something went wrong. Please try again.'),
          ),
        ),
      ),
    );
  }
}
