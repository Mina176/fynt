import 'package:fynt/core/theming/app_colors.dart';
import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:flutter/material.dart';

class OnboardingCard extends StatelessWidget {
  const OnboardingCard({
    super.key,
    this.icon,
    required this.borderRadius,
    required this.width,
    required this.height,
    required this.title,
    required this.subTitle,
    this.image,
  });
  final IconData? icon;
  final double borderRadius;
  final double width;
  final double height;
  final String title;
  final String subTitle;
  final Image? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child:
              image ??
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Icon(
                  icon,
                  color: AppColors.kPrimaryColor,
                  size: 60,
                ),
              ),
        ),
        gapH24,
        Text(
          title,
          style: TextStyles.title,
          textAlign: TextAlign.center,
        ),
        gapH12,
        Text(
          subTitle,
          style: TextStyles.subtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
