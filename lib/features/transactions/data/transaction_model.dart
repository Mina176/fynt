import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum CategoryTypes {
  food,
  transport,
  entertainment,
  shopping,
  bills,
  salary,
  freelance,
  investment,
  others,
  housing,
  health,
  gifts,
}

enum AccountType {
  debitCard(
    label: 'Debit Card',
    icon: Icons.credit_card,
  ),
  creditCard(
    label: 'Credit Card',
    icon: FontAwesomeIcons.ccVisa,
  ),
  cashWallet(
    label: 'Cash Wallet',
    icon: Icons.wallet,
  ),
  investment(
    label: 'Investment',
    icon: FontAwesomeIcons.arrowTrendUp,
  )
  ;

  final String label;
  final IconData icon;

  const AccountType({
    required this.label,
    required this.icon,
  });
}

class TransactionModel {
  final int id;
  final String userId;
  final bool isExpense;
  final double amount;
  final CategoryTypes category;
  final AccountType account;
  final DateTime date;
  final String? note;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.isExpense,
    required this.amount,
    required this.category,
    required this.account,
    required this.date,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'is_expense': isExpense,
      'amount': amount,
      'category': category.name,
      'account_type': account.name,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int,
      userId: map['user_id'] as String,
      isExpense: map['is_expense'] as bool,
      amount: (map['amount'] as num).toDouble(),
      category: CategoryTypes.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => CategoryTypes.others,
      ),
      account: AccountType.values.firstWhere(
        (e) => e.name == map['account_type'],
        orElse: () => AccountType.cashWallet,
      ),
      date: DateTime.parse(map['date']),
      note: map['note'] as String?,
    );
  }
}
