import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.widgets,
    required this.backgroundColor,
    this.header,
  });
  final Widget? header;
  final Color backgroundColor;
  final List<Widget> widgets;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header ?? const SizedBox.shrink(),
        Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              if (widgets.isEmpty)
                const SizedBox.shrink()
              else if (widgets.length == 1)
                ...widgets
              else
                ...widgets.length == 1
                      ? widgets
                      : widgets
                            .expand(
                              (widget) => [
                                widget,
                                const Divider(height: 0.1),
                              ],
                            )
                            .toList()
                  ..removeLast(),
            ],
          ),
        ),
      ],
    );
  }
}
