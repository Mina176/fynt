import 'package:fintrack/features/add_transaction/data/transaction_model.dart';

class AccountModel {
  final int? id;
  final String userId;
  final AccountTypes accountType;
  final String accountName;
  final double balance;
  final bool includeInNetWorth;
  final double currentBalance;

  AccountModel({
    this.id,
    required this.userId,
    required this.accountType,
    required this.accountName,
    required this.balance,
    required this.includeInNetWorth,
    required this.currentBalance,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'account_type': accountType.name,
      'account_name': accountName,
      'balance': balance,
      'include_in_net_worth': includeInNetWorth,
      'current_balance': currentBalance,
    };
  }

  factory AccountModel.fromJson(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'] as int?,
      userId: map['user_id'] as String,
      accountType: AccountTypes.values.firstWhere(
        (e) => e.name == map['account_type'],
        orElse: () => AccountTypes.cashWallet,
      ),
      accountName: map['account_name'] as String,
      balance: (map['balance'] as num).toDouble(),
      includeInNetWorth: map['include_in_net_worth'] as bool,
      currentBalance: (map['current_balance'] as num).toDouble(),
    );
  }
}
