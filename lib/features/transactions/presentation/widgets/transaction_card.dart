import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/features/transactions/data/transaction_model.dart';
import 'package:fynt/features/settings/currency/logic/currency_provider.dart';
import 'package:fynt/core/theming/app_colors.dart';
import 'package:fynt/core/widgets/category_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TransactionCard extends ConsumerWidget {
  const TransactionCard({super.key, required this.transaction});
  final TransactionModel transaction;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencySymbol = ref.watch(currencySymbolProvider);
    return ListTile(
      leading: CategoryIcon(categoryType: transaction.category),
      title: Text(
        transaction.category.name[0].toUpperCase() +
            transaction.category.name.substring(1),
        style: TextStyles.title.copyWith(fontSize: 16),
      ),
      subtitle: Text(
        DateFormat('EEE, MMM d').format(transaction.date),
        style: TextStyles.subtitle.copyWith(
          fontSize: 12,
        ),
      ),
      trailing: Text(
        formatDouble(transaction.amount, transaction.isExpense, currencySymbol),
        style: TextStyles.title.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: transaction.isExpense ? null : AppColors.kPrimaryColor,
        ),
      ),
    );
  }

  String formatDouble(double d, bool isExpense, String symbol) {
    String sign = isExpense ? "-" : "";
    return sign + symbol + d.toString().replaceFirst(RegExp(r'\.0*$'), '');
  }
}
