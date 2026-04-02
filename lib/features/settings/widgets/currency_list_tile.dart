import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/core/extensions/localization_extension.dart';
import 'package:fynt/core/theming/app_colors.dart';
import 'package:fynt/features/settings/currency/currency_provider.dart';

class CurrencyListTile extends ConsumerWidget {
  const CurrencyListTile({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCurrencyCode = ref.watch(currencyCodeProvider);
    return ListTile(
      onTap: () => showCurrencyPicker(
        showFlag: false,
        theme: CurrencyPickerThemeData(
          inputDecoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.kSubtitleColor,
            ),
            hintText: context.l10n.currency,
          ),
          backgroundColor: Theme.of(
            context,
          ).scaffoldBackgroundColor,
          titleTextStyle: TextStyles.title.copyWith(fontSize: 18),
          subtitleTextStyle: TextStyles.subtitle.copyWith(
            fontSize: 14,
          ),
        ),
        context: context,
        onSelect: (value) {
          ref.read(currencyCodeProvider.notifier).setCurrencyCode(value.code);
          ref
              .read(currencySymbolProvider.notifier)
              .setCurrencySymbol(value.symbol);
        },
      ),
      leading: const Icon(
        Icons.attach_money,
        color: AppColors.kPrimaryColor,
      ),
      title: Text(
        context.l10n.currency,
        style: TextStyles.labelText,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            currentCurrencyCode,
            style: TextStyles.subtitle.copyWith(fontSize: 12),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
    );
  }
}
