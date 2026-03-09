import 'package:fintrack/features/add_transaction/data/transaction_model.dart';
import 'package:fintrack/features/add_transaction/presentation/category_icon_with_label.dart';
import 'package:fintrack/widgets/category_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<CategoryIcon> spendingCategoriesList = [
  const CategoryIcon(categoryType: CategoryTypes.food),
  const CategoryIcon(categoryType: CategoryTypes.transport),
  const CategoryIcon(categoryType: CategoryTypes.health),
  const CategoryIcon(categoryType: CategoryTypes.housing),
  const CategoryIcon(categoryType: CategoryTypes.entertainment),
  const CategoryIcon(categoryType: CategoryTypes.shopping),
  const CategoryIcon(categoryType: CategoryTypes.bills),
];

final List<CategoryIcon> incomeCategoriesList = [
  const CategoryIcon(categoryType: CategoryTypes.freelance),
  const CategoryIcon(categoryType: CategoryTypes.investment),
  const CategoryIcon(categoryType: CategoryTypes.salary),
  const CategoryIcon(categoryType: CategoryTypes.gifts),
];

final List<CategoryIconWithLabel> spendingCategoriesWithLabelsList = [
  const CategoryIconWithLabel(categoryType: CategoryTypes.food),
  const CategoryIconWithLabel(categoryType: CategoryTypes.transport),
  const CategoryIconWithLabel(categoryType: CategoryTypes.health),
  const CategoryIconWithLabel(categoryType: CategoryTypes.housing),
  const CategoryIconWithLabel(categoryType: CategoryTypes.entertainment),
  const CategoryIconWithLabel(categoryType: CategoryTypes.shopping),
  const CategoryIconWithLabel(categoryType: CategoryTypes.bills),
];
final List<CategoryIconWithLabel> incomeCategoriesWithLabelsList = [
  const CategoryIconWithLabel(categoryType: CategoryTypes.freelance),
  const CategoryIconWithLabel(categoryType: CategoryTypes.investment),
  const CategoryIconWithLabel(categoryType: CategoryTypes.salary),
  const CategoryIconWithLabel(categoryType: CategoryTypes.gifts),
];

final List<Map<String, dynamic>> accountTypes = [
  {'icon': Icons.credit_card, 'label': 'Debit Card'},
  {'icon': Icons.credit_card, 'label': 'Credit Card'},
  {'icon': Icons.wallet, 'label': 'Cash Wallet'},
  {'icon': FontAwesomeIcons.arrowTrendUp, 'label': 'Investment'},
];

final List<AccountIcon> accountTypesList = [
  const AccountIcon(accountTypes: AccountTypes.cashWallet),
  const AccountIcon(accountTypes: AccountTypes.debitCard),
  const AccountIcon(accountTypes: AccountTypes.creditCard),
  const AccountIcon(accountTypes: AccountTypes.investment),
];
