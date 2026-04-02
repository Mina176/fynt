import 'package:fynt/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/widgets/settings_section.dart';
import 'package:fynt/features/settings/widgets/currency_list_tile.dart';
import 'package:fynt/features/settings/widgets/theme_list_tile.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      header: Text(
        context.l10n.appPreferences,
        style: TextStyles.subtitle.copyWith(fontSize: 12),
        textAlign: TextAlign.left,
      ),
      widgets: const [
        CurrencyListTile(),
        ThemeListTile(),
      ],
    );
  }
}
