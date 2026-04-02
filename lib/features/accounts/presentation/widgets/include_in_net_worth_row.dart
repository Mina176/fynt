import 'package:fynt/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:fynt/core/constants/text_styles.dart';

class IncludeInNetWorthRow extends StatelessWidget {
  const IncludeInNetWorthRow({
    super.key,
    required this.includeInNetWorth,
    required this.onIncludeInNetWorthChanged,
  });
  final bool includeInNetWorth;
  final ValueChanged<bool> onIncludeInNetWorthChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.includeInNetWorth,
              style: TextStyles.title.copyWith(fontSize: 14),
            ),
            const Text('Balance will affect total assets'),
          ],
        ),
        Switch(
          value: includeInNetWorth,
          onChanged: (value) => onIncludeInNetWorthChanged(value),
        ),
      ],
    );
  }
}
