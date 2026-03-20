import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/widgets/app_bar_action.dart';
import 'package:fynt/features/accounts/presentation/widgets/accounts_list.dart';
import 'package:fynt/features/accounts/presentation/widgets/balance_with_last_month.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:flutter/material.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: const [
          AppBarAction(appRoute: AppRoutes.addAccount),
          gapW20,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.kVerticalPadding,
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Balance',
              style: TextStyles.subtitle.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const BalanceWithLastMonthContainer(),
            gapH16,
            const AccountsList(),
          ],
        ),
      ),
    );
  }
}
