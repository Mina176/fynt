import 'package:flutter/material.dart';

class ScrollableContentWithStickyButton extends StatelessWidget {
  const ScrollableContentWithStickyButton({
    super.key,
    required this.upperChildren,
    required this.button,
  });
  final List<Widget> upperChildren;
  final Widget button;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: upperChildren,
            ),
          ),
        ),
        button,
      ],
    );
  }
}
