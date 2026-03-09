import 'package:currency_picker/currency_picker.dart';
import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/features/appearance/logic/theme_controller.dart';
import 'package:fintrack/features/authentication/logic/auth_controller.dart';
import 'package:fintrack/features/authentication/logic/auth_service.dart';
import 'package:fintrack/features/currency/logic/currency_provider.dart';
import 'package:fintrack/features/home%20screen/presentation/custom_app_bar.dart';
import 'package:fintrack/routing/app_route_enum.dart';
import 'package:fintrack/theming/app_colors.dart';
import 'package:fintrack/utils/helpers.dart';
import 'package:fintrack/widgets/settings_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCurrencyCode = ref.watch(currencyCodeProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyles.title.copyWith(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            DetailsSection(),
            gapH12,
            SettingsSection(
              header: Text(
                "APP PREFERENCES",
                style: TextStyles.subtitle.copyWith(fontSize: 12),
                textAlign: TextAlign.left,
              ),
              backgroundColor: Theme.of(context).cardColor,
              widgets: [
                ListTile(
                  onTap: () => showCurrencyPicker(
                    showFlag: false,
                    theme: CurrencyPickerThemeData(
                      inputDecoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.kSubtitleColor,
                        ),
                        hintText: 'Search currency name or code',
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
                      ref.read(currencyCodeProvider.notifier).state =
                          value.code;
                      ref.read(currencySymbolProvider.notifier).state =
                          value.symbol;
                    },
                  ),
                  leading: Icon(
                    Icons.attach_money,
                    color: AppColors.kPrimaryColor,
                  ),
                  title: Text(
                    'Currency',
                    style: TextStyles.labelText,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentCurrencyCode,
                        style: TextStyles.subtitle.copyWith(fontSize: 12),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, size: 14),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () => context.push(AppRoutes.setAppearance.path),
                  leading: Icon(
                    Icons.color_lens,
                    color: AppColors.kPrimaryColor,
                  ),
                  title: Text(
                    'Theme',
                    style: TextStyles.labelText,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ref.watch(themeControllerProvider) == ThemeMode.light
                            ? 'Light'
                            : 'Dark',
                        style: TextStyles.subtitle.copyWith(fontSize: 12),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, size: 14),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () =>
                  ref.read(authControllerProvider.notifier).signOut(),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.kErrorColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                  ),
                  gapW4,
                  Text('Log Out'),
                ],
              ),
            ),
            gapW16,
          ],
        ),
      ),
    );
  }
}

class DetailsSection extends ConsumerWidget {
  const DetailsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authServiceProvider).currentUser;

    final String guestId = currentUser?.userId != null
        ? currentUser!.userId.substring(0, 5)
        : '76186';

    final String displayName =
        (currentUser?.fullName != null && currentUser!.fullName.isNotEmpty)
        ? currentUser.fullName
        : 'Guest#$guestId';
    return Column(
      children: [
        Text(
          displayName,
          textAlign: TextAlign.center,
          style: TextStyles.title.copyWith(fontSize: 28),
        ),
        Text(
          currentUser?.email ?? '',
          textAlign: TextAlign.center,
          style: TextStyles.subtitle.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
