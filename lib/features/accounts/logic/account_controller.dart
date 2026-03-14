import 'package:fintrack/features/accounts/data/account_model.dart';
import 'package:fintrack/features/accounts/logic/account_supabase_service.dart';
import 'package:fintrack/features/add_transaction/logic/transaction_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_controller.g.dart';

@riverpod
class AccountController extends _$AccountController {
  @override
  FutureOr<List<AccountModel>> build() async {
    final service = ref.read(accountSupabaseServiceProvider);
    return service.getAccounts();
  }

  Future<void> createAccount(AccountModel account) async {
    state = const AsyncLoading();

    try {
      final service = ref.read(accountSupabaseServiceProvider);
      await service.createAccount(account);

      ref.invalidateSelf();
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> deleteAccount(int accountId) async {
    state = const AsyncLoading();
    if (state.hasValue) {
      final updatedList = state.value!.where((a) => a.id != accountId).toList();
      state = AsyncData(updatedList);
    }
    try {
      final service = ref.read(accountSupabaseServiceProvider);
      await service.deleteAccount(accountId);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<AccountModel> updateAccountBalance({
    required AccountModel account,
    required double amount,
    required bool isExpense,
  }) async {
    try {
      final service = ref.read(accountSupabaseServiceProvider);
      AccountModel accountToUpdate = account;
      if (account.id == null) {
        final allAccounts = state.value ?? await future;
        try {
          accountToUpdate = allAccounts.firstWhere(
            (a) =>
                a.accountType == account.accountType &&
                a.accountName == account.accountName,
          );
        } catch (e) {
          throw Exception(
            "Could not find account to update. Ensure the account exists and has an ID.",
          );
        }
      }
      final updatedAccount = await service.updateAccountBalance(
        accountToUpdate,
        amount,
        isExpense,
      );

      ref.invalidateSelf();

      return updatedAccount;
    } catch (error) {
      rethrow;
    }
  }
}

@riverpod
Future<List<AccountModel>> getAccounts(Ref ref) async {
  final service = ref.read(accountSupabaseServiceProvider);
  return service.getAccounts();
}

@riverpod
Future<double> getNetWorth(Ref ref) async {
  final accounts = await ref.watch(accountControllerProvider.future);
  double total = 0.0;
  for (var account in accounts) {
    if (account.includeInNetWorth) {
      total += account.currentBalance;
    }
  }
  return total;
}

class NetWorthStats {
  final double currentBalance;
  final int percentChange;
  NetWorthStats({required this.currentBalance, required this.percentChange});
}

@riverpod
Future<NetWorthStats> netWorthStats(Ref ref) async {
  final currentNetWorth = await ref.watch(getNetWorthProvider.future);
  final previousMonthTotal = await ref.watch(
    getPreviousMonthTotalProvider.future,
  );
  int percentageChange = 0;
  if (previousMonthTotal == 0) {
    percentageChange = currentNetWorth > 0 ? 100 : 0;
  } else {
    percentageChange =
        ((currentNetWorth - previousMonthTotal) / previousMonthTotal * 100)
            .round();
  }
  return NetWorthStats(
    currentBalance: currentNetWorth,
    percentChange: percentageChange,
  );
}
