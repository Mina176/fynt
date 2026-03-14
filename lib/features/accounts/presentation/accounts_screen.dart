import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/features/accounts/data/account_model.dart';
import 'package:fintrack/features/accounts/logic/account_controller.dart';
import 'package:fintrack/features/add_transaction/logic/transaction_controller.dart';
import 'package:fintrack/features/currency/logic/currency_provider.dart';
import 'package:fintrack/features/home_screen/presentation/custom_card.dart';
import 'package:fintrack/features/home_screen/presentation/last_month_container.dart';
import 'package:fintrack/routing/app_route_enum.dart';
import 'package:fintrack/theming/app_colors.dart';
import 'package:fintrack/widgets/settings_section.dart';
import 'package:fintrack/widgets/slidable_settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AccountsScreen extends ConsumerStatefulWidget {
  const AccountsScreen({super.key});
  @override
  ConsumerState<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends ConsumerState<AccountsScreen> {
  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountControllerProvider);
    final netWorthAsync = ref.watch(getNetWorthProvider);
    final currencySymbol = ref.watch(currencySymbolProvider);
    final isFirstMonth = ref.watch(isFirstMonthOfActivityProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
          DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: GestureDetector(
                onTap: () => context.push(AppRoutes.addAccount.path),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          gapW20,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kHorizontalPadding,
          vertical: Sizes.kVerticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Balance',
              style: TextStyles.subtitle.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  netWorthAsync.when(
                    data: (data) => '$currencySymbol${data.toStringAsFixed(2)}',
                    error: (error, stackTrace) => 'Error',
                    loading: () => '${currencySymbol}0.00',
                  ),
                  style: TextStyles.title,
                  textAlign: TextAlign.center,
                ),
                gapW4,
                isFirstMonth.value == null || isFirstMonth.value!
                    ? const SizedBox.shrink()
                    : const LastMonthContainer(
                        savingPercentage: 2,
                        isShrinked: true,
                      ),
              ],
            ),
            gapH16,
            Expanded(
              child: accountsAsync.when(
                data: (accounts) {
                  if (accounts.isEmpty) {
                    return Center(
                      child: Text(
                        'Press the + button above to add an account.',
                        textAlign: TextAlign.center,
                        style: TextStyles.subtitle.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: SettingsSection(
                      backgroundColor: Theme.of(context).cardColor,
                      widgets: List.generate(
                        accounts.length,
                        (index) {
                          final account = accounts[index];
                          return SlidableSettingsTile(
                            itemKey: ValueKey(accounts[index].id),
                            onDeleteTapped: () {
                              if (account.id != null) {
                                ref
                                    .read(accountControllerProvider.notifier)
                                    .deleteAccount(account.id!);
                              }
                            },
                            child: AccountCard(
                              icon: account.accountTypeIcon,
                              accountType: accounts[index].accountType.name,
                              accountName: accounts[index].accountName,
                              balance: accounts[index].balance,
                              currentBalance: accounts[index].currentBalance,
                              currencySymbol: currencySymbol,
                            ),
                          );
                        },
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
            ),
          ],
        ),
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.accountType,
    required this.accountName,
    required this.balance,
    required this.currentBalance,
    required this.currencySymbol,
    required this.icon,
  });
  final String accountType;
  final String accountName;
  final double balance;
  final double currentBalance;
  final String currencySymbol;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
            ),
            gapW20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  accountName,
                  style: TextStyles.title.copyWith(fontSize: 16),
                ),
                Text(
                  '$currencySymbol${balance.round()}',
                  style: TextStyles.subtitle.copyWith(fontSize: 14),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$currencySymbol${balance.toStringAsFixed(2)}',
                  style: TextStyles.title.copyWith(fontSize: 16),
                ),
                const Text(''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension GetAccountTypeIcon on AccountModel {
  IconData get accountTypeIcon {
    switch (accountType.index) {
      case 0:
        return Icons.credit_card;
      case 1:
        return FontAwesomeIcons.ccVisa;
      case 2:
        return Icons.wallet;
      default:
        return FontAwesomeIcons.arrowTrendUp;
    }
  }
}
