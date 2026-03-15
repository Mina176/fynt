import 'package:fintrack/features/add_transaction/data/transaction_model.dart';

enum RecurrenceDuration { weekly, monthly, yearly }

class BudgetModel {
  final String userId;
  final double limit;
  final double spent;
  final String budgetName;
  final CategoryTypes category;
  final RecurrenceDuration recurrenceDuration;

  BudgetModel({
    required this.limit,
    required this.spent,
    required this.budgetName,
    required this.category,
    required this.recurrenceDuration,
    required this.userId,
  });

  BudgetModel copyWith({
    String? userId,
    double? limit,
    double? spent,
    String? budgetName,
    CategoryTypes? category,
    RecurrenceDuration? recurrenceDuration,
  }) {
    return BudgetModel(
      userId: userId ?? this.userId,
      limit: limit ?? this.limit,
      spent: spent ?? this.spent,
      budgetName: budgetName ?? this.budgetName,
      category: category ?? this.category,
      recurrenceDuration: recurrenceDuration ?? this.recurrenceDuration,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'limit': limit,
      'budget_name': budgetName,
      'category': category.name,
      'recurrence_duration': recurrenceDuration.name,
      'spent': spent,
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> map) {
    return BudgetModel(
      userId: (map['user_id'] ?? "") as String,
      budgetName: (map['budget_name'] ?? "Unnamed Budget") as String,
      limit: (map['limit'] ?? 0.0).toDouble(),
      spent: (map['spent'] ?? 0.0).toDouble(),
      category: CategoryTypes.values.firstWhere(
        (e) => e.name == (map['category'] ?? ""),
        orElse: () => CategoryTypes.others,
      ),
      recurrenceDuration: RecurrenceDuration.values.firstWhere(
        (e) => e.name == (map['recurrence_duration'] ?? ""),
        orElse: () => RecurrenceDuration.monthly,
      ),
    );
  }
}
