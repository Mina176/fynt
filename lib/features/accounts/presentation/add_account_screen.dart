import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/enums/account_type.dart';
import 'package:fynt/features/accounts/data/account_model.dart';
import 'package:fynt/features/accounts/logic/account_controller.dart';
import 'package:fynt/features/accounts/presentation/widgets/account_details_form.dart';
import 'package:fynt/features/accounts/presentation/widgets/accounts_sliver_grid.dart';
import 'package:fynt/features/accounts/presentation/widgets/add_account_button.dart';
import 'package:fynt/features/accounts/presentation/widgets/include_in_net_worth_row.dart';
import 'package:fynt/features/authentication/logic/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddAccountScreen extends ConsumerStatefulWidget {
  const AddAccountScreen({super.key});
  @override
  ConsumerState<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends ConsumerState<AddAccountScreen> {
  AccountType selectedAccount = AccountType.debitCard;
  bool includeInNetWorth = true;
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void addAccount() async {
    if (isLoading) return;
    if (!formKey.currentState!.validate()) return;
    setState(() => isLoading = true);
    try {
      final currentUser = ref.read(authServiceProvider).currentUser;
      final parsedBalance = double.tryParse(balanceController.text) ?? 0.0;
      await ref
          .read(accountControllerProvider.notifier)
          .createAccount(
            AccountModel(
              userId: currentUser!.userId,
              accountType: selectedAccount,
              accountName: accountNameController.text.trim(),
              balance: parsedBalance,
              includeInNetWorth: includeInNetWorth,
              currentBalance: parsedBalance,
            ),
          );
      if (mounted) {
        context.pop();
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    accountNameController.dispose();
    balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Add Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.kVerticalPadding,
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  AccountsSliverGrid(
                    onAccountTypeSelected: (type) =>
                        setState(() => selectedAccount = type),
                    selectedAccount: selectedAccount,
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      spacing: 10,
                      children: [
                        AccountDetailsForm(
                          formKey: formKey,
                          accountNameController: accountNameController,
                          balanceController: balanceController,
                        ),
                        IncludeInNetWorthRow(
                          includeInNetWorth: includeInNetWorth,
                          onIncludeInNetWorthChanged: (value) => setState(() {
                            includeInNetWorth = value;
                          }),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AddAccountButton(
              isLoading: isLoading,
              addAccount: addAccount,
            ),
          ],
        ),
      ),
    );
  }
}
