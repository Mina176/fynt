import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LastMonthContainer extends StatelessWidget {
  const LastMonthContainer({
    super.key,
    required this.savingPercentage,
    this.isShrinked = false,
  });
  final int savingPercentage;
  final bool isShrinked;

  @override
  Widget build(BuildContext context) {
    bool isSaving = savingPercentage >= 0;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSaving
            ? AppColors.kButtonBorderColor
            : AppColors.knotSavingBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSaving
                ? const Icon(
                    FontAwesomeIcons.arrowTrendUp,
                    color: AppColors.kPrimaryColor,
                    size: 12,
                  )
                : const Icon(
                    FontAwesomeIcons.arrowTrendDown,
                    color: AppColors.knotSavingForeground,
                    size: 12,
                  ),
            gapW8,
            Text(
              isShrinked
                  ? '${savingPercentage.toString()}%'
                  : '$savingPercentage% vs last month',
              textAlign: TextAlign.center,
              style: TextStyles.buttonLabel.copyWith(
                color: isSaving
                    ? AppColors.kPrimaryColor
                    : AppColors.knotSavingForeground,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
