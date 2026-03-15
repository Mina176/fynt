import 'package:fintrack/features/add_transaction/data/transaction_model.dart';
import 'package:fintrack/features/budgets/data/budget_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'budget_supabase.g.dart';

@Riverpod(keepAlive: true)
BudgetSupabaseService budgetSupabaseService(Ref ref) {
  return BudgetSupabaseService();
}

class BudgetSupabaseService {
  String get userId => Supabase.instance.client.auth.currentUser!.id;
  Future<void> createBudget(BudgetModel budget) async {
    await Supabase.instance.client.from('budgets').insert(budget.toJson());
  }

  Future<List<BudgetModel>> getBudgets(RecurrenceDuration period) async {
    final client = Supabase.instance.client;
    final response = await client
        .from('budgets')
        .select()
        .eq('user_id', userId)
        .eq('recurrence_duration', period.name);

    final budgets = (response as List)
        .map((e) => BudgetModel.fromMap(e))
        .toList();

    final DateTime now = DateTime.now();
    final DateTime start = _getStartDate(period, now);
    final DateTime end = _getEndDate(period, now);

    final transactionsResponse = await client
        .from('transactions')
        .select()
        .gte('date', start.toIso8601String())
        .lte('date', end.toIso8601String())
        .eq('user_id', userId)
        .eq('is_expense', true);
    final transactions = (transactionsResponse as List)
        .map((e) => TransactionModel.fromJson(e))
        .toList();

    return budgets.map((budget) {
      final totalSpent = transactions
          .where((t) => t.category == budget.category)
          .fold(0.0, (sum, t) => sum + t.amount);
      return budget.copyWith(spent: totalSpent);
    }).toList();
  }

  DateTime _getStartDate(RecurrenceDuration period, DateTime now) {
    if (period == RecurrenceDuration.weekly) {
      return now.subtract(Duration(days: now.weekday - 1));
    } else if (period == RecurrenceDuration.monthly) {
      return DateTime(now.year, now.month, 1);
    }
    return DateTime(now.year, 1, 1);
  }

  DateTime _getEndDate(RecurrenceDuration period, DateTime now) {
    if (period == RecurrenceDuration.weekly) {
      final daysUntilSunday = 7 - now.weekday;
      final sunday = now.add(Duration(days: daysUntilSunday));

      return DateTime(sunday.year, sunday.month, sunday.day, 23, 59, 59);
    } else if (period == RecurrenceDuration.monthly) {
      final startOfNextMonth = DateTime(now.year, now.month + 1, 1);
      return startOfNextMonth.subtract(const Duration(seconds: 1));
    } else {
      return DateTime(now.year, 12, 31, 23, 59, 59);
    }
  }
}
