import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/widgets/settings_section.dart';
import 'package:fynt/core/widgets/slidable_settings_tile.dart';
import 'package:fynt/features/accounts/logic/account_controller.dart';
import 'package:fynt/features/accounts/presentation/account_card.dart';

class AccountsList extends ConsumerWidget {
  const AccountsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountControllerProvider);
    return Expanded(
      child: accountsAsync.when(
        skipLoadingOnReload: true,
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
                      icon: account.accountType.icon,
                      accountType: account.accountType,
                      accountName: account.accountName,
                      balance: account.balance,
                      currentBalance: account.currentBalance,
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
    );
  }
}
