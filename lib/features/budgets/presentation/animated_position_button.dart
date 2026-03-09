import 'package:flutter/material.dart';

class AnimatedPositionButton extends StatelessWidget {
  const AnimatedPositionButton({
    super.key,
    required this.onTap,
    required this.isLoading,
  });

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      left: 0,
      right: 0,
      bottom: 0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: SafeArea(
          minimum: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: onTap,
            child: isLoading
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_rounded),
                      const SizedBox(width: 8),
                      Text("Save Budget"),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
