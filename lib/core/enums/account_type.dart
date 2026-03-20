import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AccountType {
  debitCard(
    label: 'Debit Card',
    icon: Icons.credit_card,
  ),
  creditCard(
    label: 'Credit Card',
    icon: FontAwesomeIcons.ccVisa,
  ),
  cashWallet(
    label: 'Cash Wallet',
    icon: Icons.wallet,
  ),
  investment(
    label: 'Investment',
    icon: FontAwesomeIcons.arrowTrendUp,
  )
  ;

  final String label;
  final IconData icon;

  const AccountType({
    required this.label,
    required this.icon,
  });
}
