import 'package:fynt/core/extensions/localization_extension.dart';
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
        Text(
          context.l10n.recentTransactions,
          style: TextStyles.header,
        ),
        GestureDetector(
          onTap: () => context.push(AppRoutes.allTransactions.path),
          child: Text(
            context.l10n.viewAll,
            style: TextStyles.headerLink,
          ),
        ),
      ],
    );
  }
}
