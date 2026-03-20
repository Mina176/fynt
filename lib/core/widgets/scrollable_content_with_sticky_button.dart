import 'package:flutter/material.dart';

class ScrollableContentWithStickyButton extends StatelessWidget {
  const ScrollableContentWithStickyButton({
    super.key,
    required this.column,
    required this.button,
  });
  final Widget column;
  final Widget button;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: column,
          ),
        ),
        button,
      ],
    );
  }
}
