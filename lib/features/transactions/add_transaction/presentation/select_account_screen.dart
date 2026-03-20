import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/widgets/category_icon.dart';
import 'package:fynt/features/accounts/logic/account_controller.dart';
import 'package:fynt/features/settings/currency/currency_provider.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:fynt/core/theming/app_colors.dart';
import 'package:fynt/core/widgets/settings_section.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SelectAccountScreen extends ConsumerWidget {
  const SelectAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountControllerProvider);
    final currencySymbol = ref.watch(currencySymbolProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Select Account'),
      ),
      body: accountsAsync.when(
        data: (accounts) {
          if (accounts.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.kHorizontalPadding,
              ),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: 'No accounts found. Please add account first.\n',
                    style: TextStyles.subtitle,
                    children: [
                      TextSpan(
                        text: 'Go to Accounts',
                        style: TextStyles.subtitle.copyWith(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push(AppRoutes.addAccount.path);
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.kVerticalPadding,
              horizontal: Sizes.kHorizontalPadding,
            ),
            child: SingleChildScrollView(
              child: SettingsSection(
                widgets: List.generate(
                  accounts.length,
                  (index) {
                    final account = accounts[index];
                    return ListTile(
                      onTap: () {
                        context.pop(account);
                      },
                      leading: AccountIcon(
                        accountType: account.accountType,
                      ),
                      title: Text(
                        account.accountName,
                        style: TextStyles.title.copyWith(fontSize: 16),
                      ),

                      subtitle: Text(
                        '$currencySymbol${account.balance.toStringAsFixed(2)}',
                        style: TextStyles.subtitle.copyWith(
                          fontSize: 14,
                        ),
                      ),

                      trailing: Text(
                        '$currencySymbol${account.currentBalance.toStringAsFixed(2)}',
                        style: TextStyles.title.copyWith(
                          fontSize: 16,
                          color: account.currentBalance < 0
                              ? AppColors.kErrorColor
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => const Center(
          child: Text('Something went wrong. Please try again.'),
        ),
      ),
    );
  }
}
