import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/enums/category_type.dart';
import 'package:fynt/core/enums/recurrence_type.dart';
import 'package:fynt/core/widgets/scrollable_content_with_sticky_button.dart';
import 'package:fynt/features/budgets/presentation/widgets/choose_category_horizontal_listview.dart';
import 'package:fynt/features/transactions/presentation/widgets/display_amount.dart';
import 'package:fynt/features/authentication/logic/auth_service.dart';
import 'package:fynt/features/authentication/presentation/auth_field.dart';
import 'package:fynt/features/budgets/data/budget_model.dart';
import 'package:fynt/features/budgets/logic/budget_controller.dart';
import 'package:fynt/features/budgets/presentation/widgets/recurrence_duration_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddBudgetScreen extends ConsumerStatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  ConsumerState<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends ConsumerState<AddBudgetScreen> {
  final TextEditingController amountController = TextEditingController();
  final nameController = TextEditingController();
  CategoryType selectedCategory = CategoryType.food;
  RecurrenceDuration selectedDuration = RecurrenceDuration.monthly;

  void addBudget() async {
    () async {
      if (amountController.text == "0.00") return;
      try {
        final userId = ref.read(authServiceProvider).currentUser!.userId;
        await ref
            .read(
              budgetControllerProvider(
                selectedDuration,
              ).notifier,
            )
            .createBudget(
              BudgetModel(
                id: DateTime.now().millisecondsSinceEpoch,
                userId: userId,
                limit: amountController.text.isEmpty
                    ? 0.0
                    : double.parse(amountController.text),
                spent: 0.0,
                budgetName: nameController.text.isEmpty
                    ? "Unnamed Budget"
                    : nameController.text,
                category: selectedCategory,
                recurrenceDuration: selectedDuration,
              ),
            );
        if (mounted) {
          context.pop();
        }
      } catch (e) {
        throw Exception("Failed to create budget: $e");
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(budgetControllerProvider(selectedDuration))
        .isLoading;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Add Budget'),
      ),
      body: ScrollableContentWithStickyButton(
        column: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DisplayAmount(
              controller: amountController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.kHorizontalPadding,
              ),
              child: TextFieldWithLabel(
                label: 'Budget Name',
                hintText: 'e.g. Monthly Groceries',
                controller: nameController,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.kHorizontalPadding,
              ),
              child: Text('Category', style: TextStyles.labelText),
            ),
            ChooseCategoryHorizontalListView(
              selectedCategory: selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.kHorizontalPadding,
              ),
              child: Text(
                'Recurrence Duration',
                style: TextStyles.labelText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.kHorizontalPadding,
              ),
              child: RecurrenceDurationSelector(
                selectedDuration: selectedDuration,
                onChanged: (value) {
                  setState(() {
                    selectedDuration = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.kHorizontalPadding,
              ),
              child: Text(
                selectedDuration.infoText,
                style: TextStyles.subtitle.copyWith(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        button: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.kHorizontalPadding,
            vertical: Sizes.kVerticalPadding,
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : addBudget,
            child: isLoading
                ? const CircularProgressIndicator()
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle),
                      gapW4,
                      Text('Add Budget'),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
