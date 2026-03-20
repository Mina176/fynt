import 'package:fynt/core/constants/duration_constants.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fynt/core/enums/recurrence_type.dart';

class RecurrenceDurationSelector extends StatelessWidget {
  const RecurrenceDurationSelector({
    super.key,
    required this.onChanged,
    required this.selectedDuration,
  });
  final RecurrenceDuration selectedDuration;
  final ValueChanged<RecurrenceDuration> onChanged;

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
                  left: selectedDuration == RecurrenceDuration.weekly
                      ? 6
                      : selectedDuration == RecurrenceDuration.monthly
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
                        onTap: () => onChanged(
                          index == 0
                              ? RecurrenceDuration.weekly
                              : index == 1
                              ? RecurrenceDuration.monthly
                              : RecurrenceDuration.yearly,
                        ),
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
