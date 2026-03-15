import 'package:fintrack/features/add_transaction/data/transaction_model.dart';
import 'package:fintrack/features/add_transaction/logic/transaction_supabase_service.dart';
import 'package:fintrack/utils/storage_provider.dart';
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'transaction_controller.g.dart';

@riverpod
@JsonPersist()
class TransactionController extends _$TransactionController {
  @override
  FutureOr<List<TransactionModel>> build() async {
    await persist(ref.watch(storageProvider.future)).future;

    _syncWithSupabase();

    return state.value ?? <TransactionModel>[];
  }

  Future<void> _syncWithSupabase() async {
    try {
      final service = ref.read(transactionSupabaseServiceProvider);
      final freshList = await service.getTransactions();

      state = AsyncData(freshList);
    } catch (_) {}
  }

  Future<void> createTransaction(TransactionModel transaction) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(transactionSupabaseServiceProvider);
      await service.createTransaction(transaction);

      ref.invalidate(getWeeklySpendingsProvider);
      ref.invalidate(getPreviousWeekTotalProvider);
      ref.invalidate(getPreviousMonthTotalProvider);
      return service.getTransactions();
    });
  }

  Future<void> deleteTransaction(int transactionId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(transactionSupabaseServiceProvider);
      await service.deleteTransaction(transactionId);

      ref.invalidate(getWeeklySpendingsProvider);
      ref.invalidate(getPreviousWeekTotalProvider);
      ref.invalidate(getPreviousMonthTotalProvider);
      return service.getTransactions();
    });
  }
}

@riverpod
Future<List<double>> getWeeklySpendings(Ref ref) async {
  final service = ref.read(transactionSupabaseServiceProvider);
  return service.getWeeklySpendings();
}

@riverpod
Future<double> getPreviousWeekTotal(Ref ref) async {
  final service = ref.read(transactionSupabaseServiceProvider);
  return service.getPreviousWeekTotal();
}

@riverpod
Future<double> getPreviousMonthTotal(Ref ref) async {
  final service = ref.read(transactionSupabaseServiceProvider);
  return service.getPreviousMonthTotal();
}

@riverpod
Future<bool> isFirstMonthOfActivity(Ref ref) async {
  final service = ref.read(transactionSupabaseServiceProvider);
  final earliestDate = await service.getFirstTransactionDate();

  if (earliestDate == null) return true;
  final now = DateTime.now();
  return earliestDate.year == now.year && earliestDate.month == now.month;
}

@riverpod
Future<bool> isFirstWeekOfActivity(Ref ref) async {
  final service = ref.read(transactionSupabaseServiceProvider);
  final earliestDate = await service.getFirstTransactionDate();

  if (earliestDate == null) return true;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final startOfWeek = today.subtract(Duration(days: now.weekday - 1));

  return earliestDate.isAfter(startOfWeek);
}

class DashboardData {
  final List<double> weeklySpendings;
  final double totalThisWeek;
  final int percentChange;

  DashboardData({
    required this.weeklySpendings,
    required this.totalThisWeek,
    required this.percentChange,
  });
}

@riverpod
Future<DashboardData> getWeeklyDashboardData(Ref ref) async {
  final weeklyData = await ref.watch(getWeeklySpendingsProvider.future);
  final prevWeekTotal = await ref.watch(getPreviousWeekTotalProvider.future);

  final currentTotal = weeklyData.fold<double>(0.0, (sum, item) => sum + item);

  double percent = 0;

  if (prevWeekTotal > 0) {
    percent = ((prevWeekTotal - currentTotal) / prevWeekTotal) * 100;
  } else if (prevWeekTotal == 0 && currentTotal > 0) {
    percent = -100;
  } else if (prevWeekTotal == 0 && currentTotal == 0) {
    percent = 0;
  } else {
    percent = 100;
  }

  return DashboardData(
    weeklySpendings: weeklyData,
    totalThisWeek: currentTotal,
    percentChange: percent.round(),
  );
}
