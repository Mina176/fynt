import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/extensions/localization_extension.dart';
import 'package:fynt/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LastMonthContainer extends ConsumerWidget {
  const LastMonthContainer({
    super.key,
    required this.savingPercentage,
    this.isShrinked = false,
  });
  final int savingPercentage;
  final bool isShrinked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isShrinked
                  ? '${savingPercentage.toString()}%'
                  : context.l10n.vsLastMonth(savingPercentage),
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
            gapW8,
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
          ],
        ),
      ),
    );
  }
}
