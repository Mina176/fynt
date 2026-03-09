import 'package:fintrack/constants/duration_constants.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:flutter/material.dart';

class RecurrenceDurationSelector extends StatelessWidget {
  const RecurrenceDurationSelector({
    super.key,
    required this.onChanged,
    required this.selectedIndex,
  });
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final List<String> recurrenceDurations = ['Weekly', 'Monthly', 'Yearly'];
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final pillWidth = (width - 16) / 3;
        return SizedBox(
          height: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: addTransactionAnimationDuration,
                  curve: Curves.easeInCubic,
                  left: selectedIndex == 0
                      ? 6
                      : selectedIndex == 1
                      ? width / 3
                      : (width / 3) * 2,
                  top: 6,
                  bottom: 6,
                  width: pillWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hoverColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    3,
                    (index) => Expanded(
                      child: GestureDetector(
                        onTap: () => onChanged(index),
                        behavior: HitTestBehavior.opaque,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            recurrenceDurations[index],
                            style: TextStyles.labelText.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
