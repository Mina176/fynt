import 'package:fintrack/features/add_transaction/data/transaction_model.dart';
import 'package:fintrack/features/add_transaction/logic/transaction_supabase_service.dart';
import 'package:fintrack/utils/storage_provider.dart';
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_controller.g.dart';

@Riverpod(keepAlive: true)
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

      return service.getTransactions();
    });
  }

  Future<void> deleteTransaction(int transactionId) async {
    final previousState = state;
    if (state.hasValue) {
      final updatedList = state.value!
          .where((t) => t.id != transactionId)
          .toList();
      state = AsyncData(
        updatedList,
      );
    }

    try {
      final service = ref.read(transactionSupabaseServiceProvider);
      await service.deleteTransaction(transactionId);
    } catch (e) {
      state = previousState;
    }
  }
}

@Riverpod()
Future<List<double>> getWeeklySpendings(Ref ref) async {
  final transactions = await ref.watch(transactionControllerProvider.future);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final startOfWeek = today.subtract(Duration(days: now.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 7));

  List<double> weeklySpendings = List.filled(7, 0.0);
  for (var item in transactions) {
    if (item.isExpense &&
        !item.date.isBefore(startOfWeek) &&
        item.date.isBefore(endOfWeek)) {
      int dayIndex = item.date.weekday - 1;
      weeklySpendings[dayIndex] += item.amount;
    }
  }
  return weeklySpendings;
}

@Riverpod()
Future<double> getPreviousWeekTotal(Ref ref) async {
  final transactions = await ref.watch(transactionControllerProvider.future);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final currentWeekStart = today.subtract(Duration(days: now.weekday - 1));
  final lastWeekStart = currentWeekStart.subtract(const Duration(days: 7));
  final lastWeekEnd = currentWeekStart.subtract(const Duration(seconds: 1));

  double total = 0.0;
  for (var item in transactions) {
    if (item.isExpense &&
        !item.date.isBefore(lastWeekStart) &&
        !item.date.isAfter(lastWeekEnd)) {
      total += item.amount;
    }
  }
  return total;
}

@Riverpod()
Future<double> getPreviousMonthTotal(Ref ref) async {
  final transactions = await ref.watch(transactionControllerProvider.future);
  final now = DateTime.now();
  final firstDayCurrentMonth = DateTime(now.year, now.month, 1);
  final lastDayPrevMonth = firstDayCurrentMonth.subtract(
    const Duration(days: 1),
  );
  final firstDayPrevMonth = DateTime(
    lastDayPrevMonth.year,
    lastDayPrevMonth.month,
    1,
  );
  final endOfPrevMonth = DateTime(
    lastDayPrevMonth.year,
    lastDayPrevMonth.month,
    lastDayPrevMonth.day,
    23,
    59,
    59,
  );

  double total = 0.0;
  for (var item in transactions) {
    if (item.isExpense &&
        !item.date.isBefore(firstDayPrevMonth) &&
        !item.date.isAfter(endOfPrevMonth)) {
      total += item.amount;
    }
  }
  return total;
}

@Riverpod(keepAlive: true)
Future<bool> isFirstMonthOfActivity(Ref ref) async {
  final transactions = await ref.watch(transactionControllerProvider.future);
  if (transactions.isEmpty) return true;

  final earliestDate = transactions
      .map((t) => t.date)
      .reduce((a, b) => a.isBefore(b) ? a : b);
  final now = DateTime.now();
  return earliestDate.year == now.year && earliestDate.month == now.month;
}

@Riverpod(keepAlive: true)
Future<bool> isFirstWeekOfActivity(Ref ref) async {
  final transactions = await ref.watch(transactionControllerProvider.future);
  if (transactions.isEmpty) return true;

  final earliestDate = transactions
      .map((t) => t.date)
      .reduce((a, b) => a.isBefore(b) ? a : b);
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

@Riverpod(keepAlive: true)
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
