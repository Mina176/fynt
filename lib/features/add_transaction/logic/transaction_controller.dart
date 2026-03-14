import 'package:fintrack/features/add_transaction/data/transaction_model.dart';
import 'package:fintrack/features/add_transaction/logic/transaction_supabase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'transaction_controller.g.dart';

@riverpod
class TransactionController extends _$TransactionController {
  @override
  FutureOr<void> build() {}

  Future<void> createTransaction(TransactionModel transaction) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final service = ref.read(transactionSupabaseServiceProvider);
      await service.createTransaction(transaction);

      ref.invalidate(getTransactionsProvider);
      ref.invalidate(getWeeklySpendingsProvider);
    });
  }
}

@riverpod
Future<List<TransactionModel>> getTransactions(Ref ref) async {
  final service = ref.watch(transactionSupabaseServiceProvider);
  return service.getTransactions();
}

@riverpod
Future<List<double>> getWeeklySpendings(Ref ref) async {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final startOfWeek = today.subtract(Duration(days: now.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 7));

  final response = await Supabase.instance.client
      .from('transactions')
      .select('amount, date, is_expense')
      .gte('date', startOfWeek.toIso8601String())
      .lt('date', endOfWeek.toIso8601String())
      .eq('is_expense', true);

  final data = response as List<dynamic>;

  List<double> weeklySpendings = List.filled(7, 0.0);

  for (var item in data) {
    final date = DateTime.parse(item['date']);
    final amount = (item['amount'] as num).toDouble();

    int dayIndex = date.weekday - 1;
    weeklySpendings[dayIndex] += amount;
  }
  return weeklySpendings;
}

@riverpod
Future<double> getPreviousWeekTotal(Ref ref) async {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final currentWeekStart = today.subtract(Duration(days: now.weekday - 1));
  final lastWeekStart = currentWeekStart.subtract(const Duration(days: 7));
  final lastWeekEnd = currentWeekStart.subtract(const Duration(seconds: 1));

  final response = await Supabase.instance.client
      .from('transactions')
      .select('amount, is_expense')
      .gte('date', lastWeekStart.toIso8601String())
      .lte('date', lastWeekEnd.toIso8601String())
      .eq('is_expense', true);
  final data = response as List<dynamic>;
  return data.fold<double>(
    0.0,
    (double sum, dynamic item) {
      final amount = item['amount'] as num;
      return sum + amount.toDouble();
    },
  );
}

@riverpod
Future<double> getPreviousMonthTotal(Ref ref) async {
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

  final response = await Supabase.instance.client
      .from('transactions')
      .select('amount, is_expense')
      .gte('date', firstDayPrevMonth.toIso8601String())
      .lte('date', endOfPrevMonth.toIso8601String())
      .eq('is_expense', true);

  final data = response as List<dynamic>;

  return data.fold<double>(
    0.0,
    (double sum, dynamic item) {
      final amount = item['amount'] as num;
      return sum + amount.toDouble();
    },
  );
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

@riverpod
Future<bool> isFirstMonthOfActivity(Ref ref) async {
  final service = ref.watch(transactionSupabaseServiceProvider);
  final earliestDate = await service.getFirstTransactionDate();

  if (earliestDate == null) return true;

  final now = DateTime.now();
  return earliestDate.year == now.year && earliestDate.month == now.month;
}

@riverpod
Future<bool> isFirstWeekOfActivity(Ref ref) async {
  final service = ref.watch(transactionSupabaseServiceProvider);
  final earliestDate = await service.getFirstTransactionDate();

  if (earliestDate == null) return true;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final startOfWeek = today.subtract(Duration(days: now.weekday - 1));

  return earliestDate.isAfter(startOfWeek);
}
