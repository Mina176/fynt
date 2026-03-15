import 'package:fintrack/features/budgets/data/budget_model.dart';
import 'package:fintrack/features/budgets/logic/budget_supabase.dart';
import 'package:fintrack/utils/storage_provider.dart';
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_controller.g.dart';

@riverpod
class BudgetController extends _$BudgetController {
  @override
  FutureOr<List<BudgetModel>> build(RecurrenceDuration period) async {
    await persist(
      ref.watch(storageProvider.future),
      key: 'budgets_list_v3_${period.name}',
      encode: (budgets) => jsonEncode(
        budgets.map((b) => b.toJson()).toList(),
      ),
      decode: (raw) {
        final jsonString = raw;
        final list = jsonDecode(jsonString) as List<dynamic>;
        return list
            .map((e) => BudgetModel.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    ).future;

    unawaited(_syncWithSupabase());
    return state.value ?? <BudgetModel>[];
  }

  Future<void> _syncWithSupabase() async {
    try {
      final service = ref.read(budgetSupabaseServiceProvider);
      final freshList = await service.getBudgets(period);
      state = AsyncData(freshList);
    } catch (_) {}
  }

  Future<void> createBudget(BudgetModel budget) async {
    state = const AsyncLoading();

    try {
      final service = ref.read(budgetSupabaseServiceProvider);
      await service.createBudget(budget);
      state = const AsyncData(null);
      ref.invalidate(getBudgetsProvider);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

@riverpod
Future<List<BudgetModel>> getBudgets(Ref ref, RecurrenceDuration period) async {
  try {
    final service = ref.watch(budgetSupabaseServiceProvider);
    return await service.getBudgets(period);
  } catch (error) {
    throw Exception('Failed to fetch budgets: $error');
  }
}

@riverpod
Future<AllBudgetsDetails> getAllBudgetsDetails(
  Ref ref,
  RecurrenceDuration period,
) async {
  final budgets = await ref.watch(getBudgetsProvider(period).future);
  double totalLimit = 0.0;
  for (var budget in budgets) {
    totalLimit += budget.limit;
  }
  double totalSpent = 0.0;
  for (var budget in budgets) {
    totalSpent += budget.spent;
  }
  return AllBudgetsDetails(totalLimit: totalLimit, totalSpent: totalSpent);
}

class AllBudgetsDetails {
  final double totalLimit;
  final double totalSpent;

  AllBudgetsDetails({
    required this.totalLimit,
    required this.totalSpent,
  });
}
