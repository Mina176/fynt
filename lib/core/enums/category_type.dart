import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum CategoryType {
  food(
    label: 'Food',
    icon: Icons.fastfood,
    isIncome: false,
  ),
  transport(
    label: 'Transport',
    icon: Icons.directions_car,
    isIncome: false,
  ),
  entertainment(
    label: 'Entertainment',
    icon: Icons.sports_esports,
    isIncome: false,
  ),
  shopping(
    label: 'Shopping',
    icon: Icons.shopping_bag,
    isIncome: false,
  ),
  bills(
    label: 'Bills',
    icon: Icons.receipt_long,
    isIncome: false,
  ),
  salary(
    label: 'Salary',
    icon: Icons.attach_money,
    isIncome: true,
  ),
  freelance(
    label: 'Freelance',
    icon: Icons.work,
    isIncome: true,
  ),
  investment(
    label: 'Investment',
    icon: FontAwesomeIcons.arrowTrendUp,
    isIncome: true,
  ),
  housing(
    label: 'Housing',
    icon: Icons.home,
    isIncome: false,
  ),
  health(
    label: 'Health',
    icon: Icons.medical_services,
    isIncome: false,
  ),
  gifts(
    label: 'Gifts',
    icon: Icons.card_giftcard,
    isIncome: true,
  ),
  others(
    label: 'Others',
    icon: Icons.more_horiz,
    isIncome: false,
  ),
  othersIncome(
    label: 'Others',
    icon: Icons.more_horiz,
    isIncome: true,
  ),
  ;

  final String label;
  final IconData icon;
  final bool isIncome;

  const CategoryType({
    required this.label,
    required this.icon,
    required this.isIncome,
  });
}
