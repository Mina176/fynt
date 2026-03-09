
import 'package:fintrack/constants/duration_constants.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/features/home_screen/presentation/custom_card.dart';
import 'package:fintrack/theming/app_colors.dart';
import 'package:flutter/widgets.dart';

class ExpenseOrIncome extends StatelessWidget {
  const ExpenseOrIncome({
    super.key,
    required this.onChanged,
    required this.selectedIndex,
  });
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final List<String> expenseOrIncome = ['Expense', 'Income'];
    bool isSelected(int index) => selectedIndex == index;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final pillWidth = (width - 12) / 2;
        return CustomCard(
          height: 50,
          padding: EdgeInsets.all(0),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: addTransactionAnimationDuration,
                curve: Curves.easeInCubic,
                left: selectedIndex == 0 ? 4 : width - 4 - pillWidth,
                top: 6,
                bottom: 6,
                width: pillWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: selectedIndex == 0
                        ? Color(0xFF3F1212)
                        : AppColors.kBarGraphNotHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  2,
                  (index) => Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(index),
                      behavior: HitTestBehavior.opaque,
                      child: Align(
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: Duration(milliseconds: 100),
                          style: TextStyles.hintText.copyWith(
                            color: isSelected(index) && selectedIndex == 0
                                ? Color(0xFFFF453A)
                                : isSelected(index) && selectedIndex == 1
                                ? AppColors.kPrimaryColor
                                : AppColors.kSubtitleColor,
                          ),
                          child: Text(
                            expenseOrIncome[index],
                            style: TextStyle(
                              color: isSelected(index) && selectedIndex == 0
                                  ? Color(0xFFFF453A)
                                  : isSelected(index) && selectedIndex == 1
                                  ? AppColors.kPrimaryColor
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
