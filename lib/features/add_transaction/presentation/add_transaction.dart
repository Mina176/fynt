import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/features/accounts/data/account_model.dart';
import 'package:fintrack/features/accounts/logic/account_controller.dart';
import 'package:fintrack/features/add_transaction/data/transaction_model.dart';
import 'package:fintrack/features/add_transaction/logic/transaction_controller.dart';
import 'package:fintrack/features/add_transaction/presentation/add_note_section.dart';
import 'package:fintrack/features/add_transaction/presentation/animated_button_with_icon.dart';
import 'package:fintrack/features/add_transaction/presentation/display_amount.dart';
import 'package:fintrack/features/add_transaction/presentation/expense_or_income.dart';
import 'package:fintrack/utils/helpers.dart';
import 'package:fintrack/routing/app_route_enum.dart';
import 'package:fintrack/utils/category_style.dart';
import 'package:fintrack/widgets/category_icon.dart';
import 'package:fintrack/widgets/settings_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  int expenseOrIncome = 0;
  DateTime selectedDate = DateTime.now();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  CategoryIcon selectedCategory = const CategoryIcon(
    categoryType: CategoryTypes.food,
  );
  final uid = Supabase.instance.client.auth.currentUser!.id;
  late AccountModel selectedAccount = AccountModel(
    userId: uid,
    accountType: AccountTypes.debitCard,
    accountName: "Select Account",
    balance: 0.0,
    includeInNetWorth: true,
    currentBalance: 0.0,
  );

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
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
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ExpenseOrIncome(
                    selectedIndex: expenseOrIncome,
                    onChanged: (index) {
                      setState(() {
                        expenseOrIncome = index;
                      });
                    },
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  DisplayAmount(
                    controller: amountController,
                  ),
                  SizedBox(height: screenSize.height * 0.005),
                  SettingsSection(
                    widgets: [
                      ListTile(
                        dense: true,
                        onTap: () async {
                          final result = await context.push<CategoryIcon>(
                            AppRoutes.chooseCategory.path,
                          );
                          if (result != null) {
                            setState(() {
                              selectedCategory = result;
                            });
                          }
                        },
                        leading: selectedCategory,
                        title: const Text(
                          "Category",
                          style: TextStyles.addTransactionSettingstitle,
                        ),
                        subtitle: Text(
                          selectedCategory.categoryType.name,
                          style: TextStyles.addTransactionSettingsSubtitle,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        onTap: () async {
                          final result = await context.push<AccountModel>(
                            AppRoutes.selectAccount.path,
                          );
                          if (result != null) {
                            setState(() {
                              selectedAccount = result;
                            });
                          }
                        },
                        leading: getAccountIcon(
                          selectedAccount.accountType,
                        ),
                        title: Text(
                          getAccountName(selectedAccount.accountType),
                          style: TextStyles.addTransactionSettingstitle,
                        ),
                        subtitle: Text(
                          selectedAccount.accountName,
                          style: TextStyles.addTransactionSettingsSubtitle,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            initialDate: DateTime.now(),
                            builder: (context, child) => Padding(
                              padding: const EdgeInsetsGeometry.symmetric(
                                vertical: 32,
                                horizontal: 16,
                              ),
                              child: child,
                            ),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                        leading: const OtherIcons(OtherIconTypes.date),
                        title: const Text(
                          "Date",
                          style: TextStyles.addTransactionSettingstitle,
                        ),
                        subtitle: Text(
                          DateFormat('EEE, MMM d').format(selectedDate),
                          style: TextStyles.addTransactionSettingsSubtitle,
                        ),
                      ),
                    ],
                  ),
                  AddNoteSection(
                    controller: noteController,
                    screenSize: screenSize,
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: Sizes.kVerticalPadding,
                  ),
                  child: AnimatedButtonWithIcon(
                    onTap: () async {
                      if (isLoading) return;
                      if (amountController.text == "0.00") return;
                      final transaction = TransactionModel(
                        id: DateTime.now().millisecondsSinceEpoch,
                        userId: uid,
                        isExpense: expenseOrIncome == 0,
                        amount: double.tryParse(amountController.text) ?? 0.0,
                        category: selectedCategory.categoryType,
                        account: selectedAccount.accountType,
                        date: selectedDate,
                        note: noteController.text,
                      );
                      try {
                        await ref
                            .read(accountControllerProvider.notifier)
                            .updateAccountBalance(
                              account: selectedAccount,
                              amount: transaction.amount,
                              isExpense: expenseOrIncome == 0 ? true : false,
                            );
                        await ref
                            .read(transactionControllerProvider.notifier)
                            .createTransaction(transaction);
                        if (context.mounted) {
                          context.pop();
                        }
                      } catch (e) {
                        throw Exception("Failed to add transaction: $e");
                      }
                    },
                    icon: Icons.check,
                    label: "Add Transaction",
                    isLoading: isLoading,
                    expenseOrIncome: expenseOrIncome,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
