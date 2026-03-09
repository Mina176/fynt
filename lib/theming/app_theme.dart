import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    final baseTextTheme = GoogleFonts.interTextTheme(base.textTheme);
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.kPrimaryColor,
        secondary: AppColors.kPrimaryColor,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.kTitleColor,
      ),
      scaffoldBackgroundColor: AppColors.kBackgroundColor,
      cardColor: AppColors.kCardColor,
      textTheme: baseTextTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      dividerTheme: DividerThemeData(
        color: const Color(0xFF94A3B8).withOpacity(0.3),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.kPrimaryColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, Sizes.p48),
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: AppColors.kButtonLabelColor,
          textStyle: TextStyles.buttonLabel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: buildBorder(AppColors.kButtonBorderColor),
        enabledBorder: buildBorder(AppColors.kButtonBorderColor),
        focusedBorder: buildBorder(AppColors.kButtonBorderColor),
        suffixIconColor: const Color(0xFF92C9A4),
        filled: true,
        fillColor: AppColors.kTextFieldFillColor,
        hintStyle: TextStyles.hintText,
      ),
    );
  }

  static ThemeData get lightTheme {
    final base = ThemeData.light();
    final baseTextTheme = GoogleFonts.interTextTheme(base.textTheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.kPrimaryColor,
        secondary: AppColors.kPrimaryColor,
        onSurface: Colors.black,
      ),
      cardColor: const Color.fromARGB(255, 243, 243, 243),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.black,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFFE5E7EB)),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.kPrimaryColor,
        refreshBackgroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: AppColors.kButtonLabelColor,
          textStyle: TextStyles.buttonLabel,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: buildBorder(const Color(0xFFEDEFF2)),
        enabledBorder: buildBorder(const Color(0xFFEDEFF2)),
        focusedBorder: buildBorder(const Color(0xFFEDEFF2)),
        suffixIconColor: const Color(0xFF92C9A4),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        hintStyle: TextStyles.hintText,
      ),
      textTheme: baseTextTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
    );
  }
}

OutlineInputBorder buildBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: color),
  );
}
