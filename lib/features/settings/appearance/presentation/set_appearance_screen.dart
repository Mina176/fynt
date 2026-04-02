// ignore_for_file: deprecated_member_use
import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/extensions/localization_extension.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fynt/features/settings/appearance/presentation/widgets/selet_theme_row.dart';

class SetAppearanceScreen extends StatelessWidget {
  const SetAppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(context.l10n.theme),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.kVerticalPadding,
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.chooseTheme,
              style: TextStyles.title,
            ),
            Text(
              context.l10n.customizeAppearance,
            ),
            const SelectThemeRow(),
          ],
        ),
      ),
    );
  }
}
