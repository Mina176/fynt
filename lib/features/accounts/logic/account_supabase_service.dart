import 'package:fintrack/features/accounts/data/account_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'account_supabase_service.g.dart';

@Riverpod(keepAlive: true)
AccountSupabaseService accountSupabaseService(Ref ref) {
  return AccountSupabaseService();
}

class AccountSupabaseService {
  final SupabaseClient client = Supabase.instance.client;
  String get userId => client.auth.currentUser!.id;
  Future<AccountModel> createAccount(AccountModel account) async {
    final response = await client
        .from('accounts')
        .insert(account.toJson())
        .select()
        .single();

    return AccountModel.fromJson(response);
  }

  Future<void> deleteAccount(int accountId) async {
    await client
        .from('accounts')
        .delete()
        .eq('id', accountId)
        .eq('user_id', userId);
  }

  Future<List<AccountModel>> getAccounts() async {
    final response = await client
        .from('accounts')
        .select()
        .eq('user_id', userId);
    final data = response as List<dynamic>;

    return data.map((item) => AccountModel.fromJson(item)).toList();
  }

  Future<AccountModel> updateAccountBalance(
    AccountModel account,
    double amount,
    bool isExpense,
  ) async {
    if (account.id == null) {
      throw Exception('Account ID is null');
    }
    final response = await client
        .from('accounts')
        .update({
          'current_balance': isExpense
              ? account.currentBalance - amount
              : account.currentBalance + amount,
        })
        .eq('id', account.id!)
        .eq('user_id', userId)
        .select()
        .single();

    return AccountModel.fromJson(response);
  }

  Future<double> getNetWorth() async {
    final response = await client
        .from('accounts')
        .select('balance')
        .eq('user_id', userId);

    final data = response as List<dynamic>;

    double totalBalance = 0.0;

    for (var item in data) {
      totalBalance += (item['balance'] as num).toDouble();
    }

    return totalBalance;
  }
}
