import 'package:fintrack/utils/category_style.dart';
import 'package:fintrack/widgets/category_icon.dart';
import 'package:fintrack/widgets/settings_section.dart';
import 'package:flutter/material.dart';

import '../../../constants/text_styles.dart';

class AddNoteSection extends StatelessWidget {
  const AddNoteSection({
    super.key,
    required this.screenSize,
    required this.controller,
  });

  final Size screenSize;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      backgroundColor: Theme.of(context).cardColor,
      widgets: [
        ListTile(
          onTap: () {},
          leading: const OtherIcons(OtherIconTypes.note),
          trailing: const SizedBox(),
          title: const Text(
            "Note",
            style: TextStyles.addTransactionSettingstitle,
          ),
          subtitle: SizedBox(
            width: screenSize.width * 0.6,
            child: TextField(
              controller: controller,
              style: TextStyles.addTransactionSettingsSubtitle,
              decoration: const InputDecoration(
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'Add a note...',
                hintStyle: TextStyles.addTransactionSettingsSubtitle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
