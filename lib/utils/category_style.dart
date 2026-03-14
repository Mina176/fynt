import 'package:fintrack/features/add_transaction/data/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconStyle {
  final IconData? icon;
  final Color color;
  final Color backgroundColor;

  IconStyle({
    this.icon,
    required this.color,
    required this.backgroundColor,
  });
}

IconStyle getCategoryStyle(CategoryTypes type, ThemeMode themeMode) {
  switch (type) {
    // --- Spending ---
    case CategoryTypes.food:
      return IconStyle(
        icon: Icons.restaurant_rounded,
        color: const Color(0xFFFB923C),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF321704)
            : const Color(0xFFFFF2E5),
      );
    case CategoryTypes.transport:
      return IconStyle(
        icon: Icons.directions_car_rounded,
        color: themeMode == ThemeMode.dark
            ? const Color(0xFFC084FC)
            : const Color(0xFF5856D6),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF221131)
            : const Color(0xFFEBEAFF),
      );
    case CategoryTypes.housing:
      return IconStyle(
        icon: Icons.home_rounded,
        color: const Color(0xFFFACC15),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF2F2402)
            : const Color(0xFFFFF9E5),
      );
    case CategoryTypes.health:
      return IconStyle(
        icon: Icons.health_and_safety_rounded,
        color: const Color(0xFF4ADE80),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF072713)
            : const Color(0xFFE5FFEF),
      );
    case CategoryTypes.entertainment:
      return IconStyle(
        icon: Icons.movie_rounded,
        color: themeMode == ThemeMode.dark
            ? const Color(0xFFF472B6)
            : const Color(0xFFFF2D55),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF2F0E1F)
            : const Color(0xFFFFE5F1),
      );
    case CategoryTypes.shopping:
      return IconStyle(
        icon: Icons.shopping_bag_rounded,
        color: themeMode == ThemeMode.dark
            ? const Color(0xFF60A5FA)
            : const Color(0xFF007AFF),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF0C1930)
            : const Color(0xFFE5F1FF),
      );
    case CategoryTypes.bills:
      return IconStyle(
        icon: Icons.receipt_long_rounded,
        color: themeMode == ThemeMode.dark
            ? const Color(0xFF22D3EE)
            : const Color(0xFF55BEF0),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF01242A)
            : const Color(0xFFE5FCFF),
      );
    case CategoryTypes.freelance:
      return IconStyle(
        icon: Icons.work_rounded,
        color: themeMode == ThemeMode.dark
            ? const Color(0xFF818CF8)
            : const Color(0xFF5B21B6),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF141430)
            : const Color(0xFFEDE9FE),
      );
    case CategoryTypes.investment:
      return IconStyle(
        icon: Icons.trending_up_rounded,
        color: themeMode == ThemeMode.dark
            ? const Color(0xFFFB7185)
            : const Color(0xFFFF453A),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF310D13)
            : const Color(0xFFFFE5E5),
      );
    case CategoryTypes.salary:
      return IconStyle(
        icon: FontAwesomeIcons.moneyBills,
        color: themeMode == ThemeMode.dark
            ? const Color(0xFF34D399)
            : const Color(0xFF30D158),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF03251A)
            : const Color(0xFFEAFFF4),
      );
    case CategoryTypes.gifts:
      return IconStyle(
        icon: Icons.card_giftcard_rounded,
        color: themeMode == ThemeMode.dark
            ? const Color(0xFF2DD4BF)
            : const Color(0xFF64D2FF),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF042521)
            : const Color(0xFFE5FFFD),
      );
    default:
      return IconStyle(
        icon: Icons.more_horiz_rounded,
        color: Colors.grey,
        backgroundColor: Colors.grey.shade100,
      );
  }
}

IconStyle getAccountStyle(AccountTypes type, ThemeMode themeMode) {
  switch (type) {
    case AccountTypes.debitCard:
      return IconStyle(
        color: themeMode == ThemeMode.dark
            ? Colors.blueGrey.shade300
            : const Color(0xFF0284C7),
        backgroundColor: themeMode == ThemeMode.dark
            ? Colors.blueGrey.shade100
            : const Color(0xFFE0F2FE),
      );
    case AccountTypes.creditCard:
      return IconStyle(
        color: themeMode == ThemeMode.dark
            ? Colors.orange.shade300
            : const Color(0xFFEA580C),
        backgroundColor: themeMode == ThemeMode.dark
            ? Colors.orange.shade900
            : const Color(0xFFFFF2E6),
      );
    case AccountTypes.cashWallet:
      return IconStyle(
        color: themeMode == ThemeMode.dark
            ? Colors.brown.shade300
            : const Color(0xFF2E7D32),
        backgroundColor: themeMode == ThemeMode.dark
            ? Colors.brown.shade900
            : const Color(0xFFE8F5E9),
      );
    case AccountTypes.investment:
      return IconStyle(
        color: themeMode == ThemeMode.dark
            ? Colors.green.shade300
            : const Color(0xFFE11D48),
        backgroundColor: themeMode == ThemeMode.dark
            ? const Color(0xFF0F2F1C)
            : const Color(0xFFFFF1F2),
      );
  }
}

enum OtherIconTypes { date, note }

IconStyle getIconStyle(OtherIconTypes type) {
  switch (type) {
    case OtherIconTypes.date:
      return IconStyle(
        icon: Icons.calendar_today_rounded,
        color: const Color(0xFF60A5FA),
        backgroundColor: const Color(0xFF223049),
      );
    case OtherIconTypes.note:
      return IconStyle(
        icon: FontAwesomeIcons.noteSticky,
        color: const Color(0xFF9CA3AF),
        backgroundColor: const Color(0xFF2A2F38),
      );
  }
}
