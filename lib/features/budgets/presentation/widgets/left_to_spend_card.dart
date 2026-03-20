import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/features/settings/currency/logic/currency_provider.dart';
import 'package:fynt/core/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeftToSpendCard extends ConsumerWidget {
  const LeftToSpendCard({
    super.key,
    required this.spentAmount,
    required this.spendLimit,
    required this.leading,
  });
  final double spentAmount;
  final double spendLimit;
  final Widget leading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencySymbol = ref.read(currencySymbolProvider);
    final double progressValue = spendLimit == 0
        ? 0.0
        : (spentAmount / spendLimit).clamp(0.0, 1.0);
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            leading,
            gapH16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Spent',
                  style: TextStyles.subtitle.copyWith(fontSize: 12),
                ),
                Text(
                  '$currencySymbol${spentAmount.round()} / $currencySymbol${spendLimit.round()}',
                  style: TextStyles.subtitle.copyWith(fontSize: 12),
                ),
              ],
            ),
            gapH8,
            LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Theme.of(context).dividerTheme.color,
              minHeight: 6,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
      ),
    );
  }
}
