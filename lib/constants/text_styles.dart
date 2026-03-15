import 'package:fintrack/theming/app_colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static const title = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 32,
    letterSpacing: 0.1,
    height: 1.2,
  );

  static const subtitle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.4,
  );

  static const buttonLabel = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const hintText = TextStyle(
    color: Color(0xFF5A8069),
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static const labelText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const header = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 18,
  );

  static const headerLink = TextStyle(
    color: AppColors.kPrimaryColor,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static const amount = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 48,
    height: 1.5,
  );

  static const addTransactionSettingstitle = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 14,
  );
  static const addTransactionSettingsSubtitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
}
