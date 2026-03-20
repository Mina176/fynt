import 'package:flutter/material.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/utils/category_style.dart';
import 'package:fynt/core/widgets/category_icon.dart';
import 'package:fynt/core/widgets/settings_section.dart';
import 'package:fynt/features/accounts/data/account_model.dart';
import 'package:fynt/features/transactions/data/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({
    super.key,
    required this.transaction,
    required this.selectedAccount,
    required this.onSelectCategory,
    required this.onSelectAccount,
    required this.onSelectDate,
  });

  final TransactionModel transaction;
  final AccountModel selectedAccount;
  final VoidCallback? onSelectCategory;
  final VoidCallback? onSelectAccount;
  final VoidCallback? onSelectDate;
  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      widgets: [
        ListTile(
          dense: true,
          onTap: onSelectCategory,
          leading: CategoryIcon(categoryType: transaction.category),
          title: const Text(
            "Category",
            style: TextStyles.addTransactionSettingstitle,
          ),
          subtitle: Text(
            transaction.category.name,
            style: TextStyles.addTransactionSettingsSubtitle,
          ),
        ),
        ListTile(
          dense: true,
          onTap: onSelectAccount,
          leading: AccountIcon(
            accountType: selectedAccount.accountType,
          ),
          title: Text(
            selectedAccount.accountType.label,
            style: TextStyles.addTransactionSettingstitle,
          ),
          subtitle: Text(
            selectedAccount.accountName,
            style: TextStyles.addTransactionSettingsSubtitle,
          ),
        ),
        ListTile(
          dense: true,
          onTap: onSelectDate,
          leading: const OtherIcons(OtherIconTypes.date),
          title: const Text(
            "Date",
            style: TextStyles.addTransactionSettingstitle,
          ),
          subtitle: Text(
            DateFormat('EEE, MMM d').format(transaction.date),
            style: TextStyles.addTransactionSettingsSubtitle,
          ),
        ),
      ],
    );
  }
}
