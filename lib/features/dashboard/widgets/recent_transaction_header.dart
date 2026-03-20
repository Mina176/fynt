import 'package:flutter/material.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:go_router/go_router.dart';

class RecentTransactionHeader extends StatelessWidget {
  const RecentTransactionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Recent Transactions',
          style: TextStyles.header,
        ),
        GestureDetector(
          onTap: () => context.push(AppRoutes.allTransactions.path),
          child: const Text(
            'View All',
            style: TextStyles.headerLink,
          ),
        ),
      ],
    );
  }
}
