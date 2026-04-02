// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/theming/app_colors.dart';
import 'package:fynt/core/widgets/custom_card.dart';
import 'package:fynt/features/settings/appearance/logic/theme_controller.dart';

class SelectThemeRow extends ConsumerWidget {
  const SelectThemeRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeControllerProvider);
    return Row(
      children: List.generate(
        2,
        (index) {
          final isLightCard = index == 0;
          final isSelected = isLightCard
              ? currentTheme == ThemeMode.light
              : currentTheme == ThemeMode.dark;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () => ref
                    .read(themeControllerProvider.notifier)
                    .setTheme(
                      index == 0 ? ThemeMode.light : ThemeMode.dark,
                    ),
                child: CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: isLightCard
                                ? Colors.white
                                : AppColors.kBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.05,
                                    width: 36,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: isLightCard
                                            ? Colors.grey[300]
                                            : Colors.grey[700],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.1,
                                    width: double.infinity,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: isLightCard
                                            ? Colors.grey[300]
                                            : Colors.grey[700],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    spacing: 8,
                                    children: List.generate(
                                      2,
                                      (index) => Expanded(
                                        child: SizedBox(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.20,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: isLightCard
                                                  ? Colors.grey[300]
                                                  : Colors.grey[700],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    8,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(flex: 1),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.08,
                                    width: double.infinity,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: isLightCard
                                            ? AppColors.kPrimaryColor
                                                  .withOpacity(
                                                    0.2,
                                                  )
                                            : AppColors.kPrimaryColor
                                                  .withOpacity(
                                                    0.4,
                                                  ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      gapH12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isLightCard ? 'Light' : 'Dark',
                            style: TextStyles.title.copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            height: 22,
                            width: 22,
                            child: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    size: 22,
                                    color: AppColors.kPrimaryColor,
                                  )
                                : null,
                          ),
                        ],
                      ),
                      Text(
                        isLightCard ? 'Clean and bright' : 'Easy on the eyes',
                        style: TextStyles.subtitle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
