import 'package:fintrack/features/add%20transaction/data/transaction_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'transaction_supabase_service.g.dart';

@Riverpod(keepAlive: true)
TransactionSupabaseService transactionSupabaseService(Ref ref) {
  return TransactionSupabaseService();
}

class TransactionSupabaseService {
  String get userId => Supabase.instance.client.auth.currentUser!.id;
  Future<void> createTransaction(TransactionModel transaction) async {
    await Supabase.instance.client
        .from('transactions')
        .insert(transaction.toMap());
  }

  Future<List<TransactionModel>> getTransactions() async {
    final response = await Supabase.instance.client
        .from('transactions')
        .select()
        .eq('user_id', userId)
        .order('id', ascending: false);

    final data = response as List<dynamic>;

    return data.map((item) => TransactionModel.fromMap(item)).toList();
  }

  Future<List<double>> getWeeklySpendings() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startOfWeek = today.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    final response = await Supabase.instance.client
        .from('transactions')
        .select('amount, date, is_expense')
        .eq('user_id', userId)
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

  Future<DateTime?> getFirstTransactionDate() async {
    final response = await Supabase.instance.client
        .from('transactions')
        .select('date')
        .eq('user_id', userId)
        .order('date', ascending: true)
        .limit(1);

    final data = response as List<dynamic>;
    if (data.isEmpty) return null;

    return DateTime.parse(data[0]['date']);
  }
}
