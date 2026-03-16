import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.widgets,
    this.header,
  });
  final Widget? header;
  final List<Widget> widgets;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header ?? const SizedBox.shrink(),
        Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              if (widgets.isNotEmpty)
                ...widgets
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
