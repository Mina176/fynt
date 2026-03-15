import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/features/accounts/logic/account_controller.dart';
import 'package:fintrack/features/add_transaction/logic/transaction_controller.dart';
import 'package:fintrack/features/home_screen/presentation/transaction_card.dart';
import 'package:fintrack/widgets/settings_section.dart';
import 'package:fintrack/widgets/slidable_settings_tile.dart';
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
                  'Press the + button above to add a transaction.',
                  textAlign: TextAlign.center,
                  style: TextStyles.subtitle.copyWith(
                    color: Colors.grey,
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: SettingsSection(
                backgroundColor: Theme.of(context).cardColor,
                widgets: List.generate(
                  transactions.length,
                  (index) {
                    final transaction = transactions[index];
                    return SlidableSettingsTile(
                      itemKey: ValueKey(transactions[index].id),
                      onDeleteTapped: () {
                        if (transaction.id != null) {
                          ref
                              .read(transactionControllerProvider.notifier)
                              .deleteTransaction(transaction.id!);
                        }
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
