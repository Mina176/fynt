import 'package:fintrack/theming/app_colors.dart';
import 'package:flutter/material.dart';

class SliderIndex extends StatelessWidget {
  const SliderIndex({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.all(4),
          width: currentPage == index ? 36 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppColors.kPrimaryColor
                : const Color(0xFF21452D),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
