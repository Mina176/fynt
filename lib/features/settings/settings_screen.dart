import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fynt/features/settings/widgets/settings_content.dart';
import 'package:fynt/features/settings/widgets/user_info_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyles.title.copyWith(fontSize: 18),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.kVerticalPadding,
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: Column(
          spacing: 12,
          children: [
            UserInfoSection(),
            gapH12,
            SettingsContent(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
