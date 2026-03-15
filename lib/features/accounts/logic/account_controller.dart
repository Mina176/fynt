import 'package:fintrack/features/accounts/data/account_model.dart';
import 'package:fintrack/features/accounts/logic/account_supabase_service.dart';
import 'package:fintrack/features/add_transaction/logic/transaction_controller.dart';
import 'package:fintrack/utils/storage_provider.dart';
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_controller.g.dart';

@Riverpod(keepAlive: true)
@JsonPersist()
class AccountController extends _$AccountController {
  @override
  FutureOr<List<AccountModel>> build() async {
    await persist(ref.watch(storageProvider.future)).future;

    _syncWithSupabase();

    return state.value ?? <AccountModel>[];
  }

  Future<void> _syncWithSupabase() async {
    try {
      final service = ref.read(accountSupabaseServiceProvider);
      final freshList = await service.getAccounts();

      state = AsyncData(freshList);
    } catch (_) {}
  }

  Future<void> createAccount(AccountModel account) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(accountSupabaseServiceProvider);
      await service.createAccount(account);

      return service.getAccounts();
    });
  }

  Future<void> deleteAccount(int accountId) async {
    final previousState = state;

    if (state.hasValue) {
      final updatedList = state.value!.where((a) => a.id != accountId).toList();
      state = AsyncData(updatedList);
    }
    try {
      final service = ref.read(accountSupabaseServiceProvider);
      await service.deleteAccount(accountId);
    } catch (error) {
      state = previousState;
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

      final newList = await service.getAccounts();
      state = AsyncData(newList);

      return updatedAccount;
    } catch (error) {
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
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

@Riverpod(keepAlive: true)
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
