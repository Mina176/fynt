import 'package:flutter/material.dart';

class AppColors {
  static const kPrimaryColor = Color(0xFF13EC5B);
  static const kBackgroundColor = Color(0xFF102216);
  static const kCardColor = Color(0xFF193322);

  static const kTitleColor = Color(0xFFFFFFFF);
  static const kSubtitleColor = Color(0xFFB3B3B3);
  static const kButtonLabelColor = Color(0xFF102216);
  static const kTransparentButtonlabelColor = Color(0xFF92C9A4);
  static const kButtonBorderColor = Color(0xFF326744);
  static const surfaceDark = Color(0xFF1E1E1E);

  static const kDarkSavingBackground = Color(0xFF326744);
  static const kDarkSavingForeground = Color(0xFF13EC5B);

  static const kDarkNotSavingBackground = Color(0xFF2F3025);
  static const kDarkNotSavingForeground = Color(0xFFF87171);

  static const kLightNotSavingBackground = Color(0xFFFEF2F2);
  static const kLightNotSavingForeground = Color(0xFFEF4444);

  static const kLightSavingBackground = Color(0xFFDBF7E2);
  static const kLightSavingForeground = Color(0xFF16A34A);

  static const kCustomContainerBackground = Color(0xFF1A2E22);

  static const kTextFieldFillColor = Color(0xFF1A2E22);

  static const kBarGraphNotHighest = Color(0xFF18532D);

  static const kProfileDividerColor = Color(0xFF2C3E32);
  static const kAddTransactionDividerColor = Color(0xFF2E2E30);

  static const kKeyboardColor = Color(0xFF1A1A1C);
  static const kKeyboardKeyColor = Color(0xFF434344);

  static const kDefaultTileBackground = Color(0xFF1C1C1E);
  static const kErrorColor = Color(0xFFF43F5E);

  static const darkGradientColors = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D2018), Colors.black],
  );

  static const lightGradientColors = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D2018), Colors.white],
  );
}
