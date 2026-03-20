// ignore_for_file: deprecated_member_use

import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/widgets/custom_card.dart';
import 'package:fynt/features/settings/appearance/logic/theme_controller.dart';
import 'package:fynt/features/settings/appearance/presentation/widgets/selet_theme_row.dart';

class SetAppearanceScreen extends StatelessWidget {
  const SetAppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Appearance'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.kVerticalPadding,
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Theme',
              style: TextStyles.title,
            ),
            Text(
              'Customize the look of your money tracker Select a theme to preview how your dashboard and transactions appear.',
            ),
            SelectThemeRow(),
          ],
        ),
      ),
    );
  }
}
