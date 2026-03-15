import 'package:fintrack/features/accounts/presentation/accounts_screen.dart';
import 'package:fintrack/features/authentication/presentation/profile_screen.dart';
import 'package:fintrack/features/budgets/presentation/budgets_screen.dart';
import 'package:fintrack/features/home_screen/presentation/home_screen.dart';
import 'package:fintrack/routing/app_route_enum.dart';
import 'package:fintrack/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootHomeScreen extends StatefulWidget {
  const RootHomeScreen({super.key});

  @override
  State<RootHomeScreen> createState() => _RootHomeScreenState();
}

class _RootHomeScreenState extends State<RootHomeScreen> {
  int _currentIndex = 0;
  final List<Widget> pages = [
    const HomeScreen(),
    const AccountsScreen(),
    const BudgetsScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: const CustomFabLocation(20),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addTransaction.path),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: FABBottomAppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onTabSelected: (index) {
          setState(() => _currentIndex = index);
        },
        color: AppColors.kSubtitleColor,
        selectedColor: AppColors.kPrimaryColor,
        items: [
          FABBottomAppBarItem(
            text: 'Home',
            iconData: Icons.home_rounded,
          ),
          FABBottomAppBarItem(
            text: 'Wallet',
            iconData: Icons.account_balance_wallet,
          ),
          FABBottomAppBarItem(
            text: 'Budgets',
            iconData: Icons.pie_chart,
          ),
          FABBottomAppBarItem(
            text: 'Profile',
            iconData: Icons.person,
          ),
        ],
      ),
    );
  }
}

class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconData, required this.text});
  IconData iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    super.key,
    required this.items,
    this.centerItemText,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    required this.onTabSelected,
  }) {
    assert(items.length == 2 || items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String? centerItemText;
  final double height;
  final double iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      color: widget.backgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: widget.iconSize),
          Text(
            widget.centerItemText ?? '',
            style: TextStyle(color: widget.color),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color? color = _selectedIndex == index
        ? widget.selectedColor
        : widget.color;
    return Expanded(
      child: InkWell(
        onTap: () => onPressed(index),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(item.iconData, color: color, size: widget.iconSize),
            Text(
              item.text,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFabLocation extends FloatingActionButtonLocation {
  final double offsetY;

  const CustomFabLocation([this.offsetY = 0]);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX =
        (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2.0;

    final double standardY =
        scaffoldGeometry.contentBottom -
        (scaffoldGeometry.floatingActionButtonSize.height / 2.0);

    return Offset(fabX, standardY + offsetY);
  }
}
