import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/enums/account_type.dart';
import 'package:fynt/core/enums/category_type.dart';
import 'package:fynt/core/widgets/scrollable_content_with_sticky_button.dart';
import 'package:fynt/features/accounts/data/account_model.dart';
import 'package:fynt/features/accounts/logic/account_controller.dart';
import 'package:fynt/features/transactions/data/transaction_model.dart';
import 'package:fynt/features/transactions/logic/transaction_controller.dart';
import 'package:fynt/features/transactions/presentation/widgets/add_note_section.dart';
import 'package:fynt/features/transactions/presentation/widgets/animated_button_with_icon.dart';
import 'package:fynt/features/transactions/presentation/widgets/display_amount.dart';
import 'package:fynt/features/transactions/presentation/widgets/expense_or_income.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/features/transactions/presentation/widgets/transaction_details.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  int expenseOrIncome = 0;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  late TransactionModel transaction;
  late AccountModel selectedAccount;

  @override
  void initState() {
    super.initState();
    final uid = Supabase.instance.client.auth.currentUser!.id;
    selectedAccount = AccountModel(
      userId: uid,
      accountType: AccountType.debitCard,
      accountName: "Select Account",
      balance: 0.0,
      includeInNetWorth: true,
      currentBalance: 0.0,
    );
    transaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch,
      userId: uid,
      isExpense: true,
      amount: 0.0,
      category: CategoryType.food,
      account: selectedAccount.accountType,
      date: DateTime.now(),
      note: "",
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void addTransaction() async {
    if (amountController.text == "0.00" || amountController.text.isEmpty) {
      return;
    }
    transaction = transaction.copyWith(
      amount: double.tryParse(amountController.text) ?? 0.0,
      note: noteController.text,
    );
    try {
      await ref
          .read(accountControllerProvider.notifier)
          .updateAccountBalance(
            account: selectedAccount,
            amount: transaction.amount,
            isExpense: transaction.isExpense,
          );
      await ref
          .read(transactionControllerProvider.notifier)
          .createTransaction(transaction);
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        context.pop();
      }
    } catch (e) {
      throw Exception("Failed to add transaction: $e");
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() => transaction = transaction.copyWith(date: pickedDate));
    }
  }

  Future<void> selectAccount(BuildContext context) async {
    final result = await context.push<AccountModel>(
      AppRoutes.selectAccount.path,
    );
    if (result != null) {
      setState(() {
        selectedAccount = result;
        transaction = transaction.copyWith(account: result.accountType);
      });
    }
  }

  Future<void> selectCategory(BuildContext context) async {
    final result = await context.push<CategoryType>(
      AppRoutes.chooseCategory.path,
      extra: expenseOrIncome,
    );
    if (result != null) {
      setState(() => transaction = transaction.copyWith(category: result));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final transactionState = ref.watch(transactionControllerProvider);
    final accountState = ref.watch(accountControllerProvider);
    final isLoading = transactionState.isLoading || accountState.isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Transaction",
          style: TextStyles.title.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.kVerticalPadding,
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: ScrollableContentWithStickyButton(
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExpenseOrIncome(
                selectedIndex: expenseOrIncome,
                onChanged: (index) => setState(() => expenseOrIncome = index),
              ),
              SizedBox(height: screenSize.height * 0.01),
              DisplayAmount(
                controller: amountController,
              ),
              SizedBox(height: screenSize.height * 0.005),
              TransactionDetails(
                transaction: transaction,
                selectedAccount: selectedAccount,
                onSelectCategory: () => selectCategory(context),
                onSelectAccount: () => selectAccount(context),
                onSelectDate: () => selectDate(context),
              ),
              AddNoteSection(
                controller: noteController,
                screenSize: screenSize,
              ),
            ],
          ),
          button: Padding(
            padding: const EdgeInsets.only(
              bottom: Sizes.kVerticalPadding,
            ),
            child: AnimatedButtonWithIcon(
              onTap: addTransaction,
              icon: Icons.check,
              label: "Add Transaction",
              isLoading: isLoading,
              expenseOrIncome: expenseOrIncome,
            ),
          ),
        ),
      ),
    );
  }
}
