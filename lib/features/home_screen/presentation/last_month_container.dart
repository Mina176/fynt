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
        color: isSaving && Theme.brightnessOf(context) == Brightness.dark
            ? AppColors.kDarkSavingBackground
            : isSaving && Theme.brightnessOf(context) == Brightness.light
            ? AppColors.kLightSavingBackground
            : !isSaving && Theme.brightnessOf(context) == Brightness.dark
            ? AppColors.kDarkNotSavingBackground
            : AppColors.kLightNotSavingBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSaving && Theme.brightnessOf(context) == Brightness.dark
              ? AppColors.kDarkSavingForeground
              : isSaving && Theme.brightnessOf(context) == Brightness.light
              ? AppColors.kLightSavingForeground
              : !isSaving && Theme.brightnessOf(context) == Brightness.dark
              ? AppColors.kDarkNotSavingForeground
              : AppColors.kLightNotSavingForeground,
          width: 0.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSaving
                ? Icon(
                    FontAwesomeIcons.arrowTrendUp,
                    color: Theme.brightnessOf(context) == Brightness.dark
                        ? AppColors.kDarkSavingForeground
                        : AppColors.kLightSavingForeground,
                    size: 12,
                  )
                : Icon(
                    FontAwesomeIcons.arrowTrendDown,
                    color: Theme.brightnessOf(context) == Brightness.dark
                        ? AppColors.kDarkNotSavingForeground
                        : AppColors.kLightNotSavingForeground,
                    size: 12,
                  ),
            gapW8,
            Text(
              isShrinked
                  ? '${savingPercentage.toString()}%'
                  : '$savingPercentage% vs last month',
              textAlign: TextAlign.center,
              style: TextStyles.buttonLabel.copyWith(
                color:
                    isSaving && Theme.brightnessOf(context) == Brightness.dark
                    ? AppColors.kDarkSavingForeground
                    : isSaving &&
                          Theme.brightnessOf(context) == Brightness.light
                    ? AppColors.kLightSavingForeground
                    : !isSaving &&
                          Theme.brightnessOf(context) == Brightness.dark
                    ? AppColors.kDarkNotSavingForeground
                    : AppColors.kLightNotSavingForeground,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
