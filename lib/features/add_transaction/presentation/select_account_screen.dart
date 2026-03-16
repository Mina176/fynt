import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/features/accounts/logic/account_controller.dart';
import 'package:fintrack/features/currency/logic/currency_provider.dart';
import 'package:fintrack/routing/app_route_enum.dart';
import 'package:fintrack/theming/app_colors.dart';
import 'package:fintrack/utils/helpers.dart';
import 'package:fintrack/widgets/settings_section.dart' show SettingsSection;
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
              horizontal: Sizes.kHorizontalPadding,
            ),
            child: SingleChildScrollView(
              child: SettingsSection(
                widgets: List.generate(
                  accounts.length,
                  (index) {
                    return ListTile(
                      onTap: () {
                        context.pop(accounts[index]);
                      },
                      leading: getAccountIcon(accounts[index].accountType),
                      title: Text(
                        accounts[index].accountName,
                        style: TextStyles.title.copyWith(fontSize: 16),
                      ),

                      subtitle: Text(
                        '$currencySymbol${accounts[index].balance.toStringAsFixed(2)}',
                        style: TextStyles.subtitle.copyWith(
                          fontSize: 14,
                        ),
                      ),

                      trailing: Text(
                        '$currencySymbol${accounts[index].currentBalance.toStringAsFixed(2)}',
                        style: TextStyles.title.copyWith(
                          fontSize: 16,
                          color: accounts[index].currentBalance < 0
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
