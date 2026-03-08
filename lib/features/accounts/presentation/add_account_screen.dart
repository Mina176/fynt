import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/features/accounts/data/account_model.dart';
import 'package:fintrack/features/accounts/logic/account_controller.dart';
import 'package:fintrack/utils/categories_lists.dart';
import 'package:fintrack/features/add%20transaction/data/transaction_model.dart';
import 'package:fintrack/features/authentication/logic/auth_service.dart';
import 'package:fintrack/features/authentication/presentation/auth_field.dart';
import 'package:fintrack/features/home%20screen/presentation/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddAccountScreen extends ConsumerStatefulWidget {
  const AddAccountScreen({super.key});
  @override
  ConsumerState<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends ConsumerState<AddAccountScreen> {
  AccountTypes selectedAccount = AccountTypes.debitCard;
  bool includeInNetWorth = true;
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(accountControllerProvider).isLoading;
    ref.listen(accountControllerProvider, (previous, next) {
      if (previous?.isLoading == true && !next.isLoading && !next.hasError) {
        context.pop();
      }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Add Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kHorizontalPadding,
          vertical: Sizes.kVerticalPadding,
        ),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                spacing: 10,
                children: [
                  GridView.builder(
                    itemCount: accountTypes.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.7,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                    itemBuilder: (context, index) {
                      final isSelected =
                          selectedAccount == AccountTypes.values[index];
                      return GestureDetector(
                        onTap: () => setState(
                          () => selectedAccount = AccountTypes.values[index],
                        ),
                        child: CustomCard(
                          isSelected: isSelected,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(accountTypes[index]['icon'], size: 28),
                              gapH4,
                              Text(
                                accountTypes[index]['label'],
                                style: TextStyles.subtitle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      spacing: 10,
                      children: [
                        TextFieldWithLabel(
                          label: 'ACCOUNT NAME',
                          hintText: 'e.g. My Savings',
                          controller: accountNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Account name is required';
                            }
                            return null;
                          },
                        ),
                        TextFieldWithLabel(
                          label: 'ACCOUNT BALANCE',
                          hintText: '0.0',
                          controller: balanceController,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Account Balance is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Include in Net Worth',
                            style: TextStyles.title.copyWith(fontSize: 14),
                          ),
                          Text('Balance will affect total assets'),
                        ],
                      ),
                      Switch(
                        value: includeInNetWorth,
                        onChanged: (value) => setState(() {
                          includeInNetWorth = value;
                        }),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: Sizes.kVerticalPadding,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (isLoading) return;
                        if (formKey.currentState!.validate()) {
                          final userId = ref
                              .read(authServiceProvider)
                              .currentUser!
                              .userId;
                          ref
                              .read(accountControllerProvider.notifier)
                              .createAccount(
                                AccountModel(
                                  userId: userId,
                                  accountType: selectedAccount,
                                  accountName: accountNameController.text,
                                  balance:
                                      double.tryParse(balanceController.text) ??
                                      0.0,
                                  includeInNetWorth: includeInNetWorth,
                                  currentBalance:
                                      double.tryParse(balanceController.text) ??
                                      0.0,
                                ),
                              );
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Add Account',
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
