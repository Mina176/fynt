import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/utils/helpers.dart';
import 'package:fynt/core/widgets/custom_card.dart';
import 'package:fynt/features/settings/currency/logic/currency_provider.dart';
import 'package:fynt/features/transactions/data/transaction_model.dart';

class AccountCard extends ConsumerWidget {
  const AccountCard({
    super.key,
    required this.accountType,
    required this.accountName,
    required this.balance,
    required this.currentBalance,
    required this.icon,
  });
  final AccountType accountType;
  final String accountName;
  final double balance;
  final double currentBalance;
  final IconData icon;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencySymbol = ref.watch(currencySymbolProvider);
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            getAccountIcon(accountType),
            gapW16,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  accountName,
                  style: TextStyles.title.copyWith(fontSize: 16),
                ),
                Text(
                  '$currencySymbol${balance.round()}',
                  style: TextStyles.subtitle.copyWith(fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$currencySymbol${currentBalance.toStringAsFixed(2)}',
                  style: TextStyles.title.copyWith(fontSize: 16),
                ),
                const Text(''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
