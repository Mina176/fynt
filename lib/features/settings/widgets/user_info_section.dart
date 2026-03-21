import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/features/authentication/logic/auth_controller.dart';
import 'package:fynt/features/authentication/logic/auth_service.dart';

class UserInfoSection extends ConsumerWidget {
  const UserInfoSection({super.key});

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
      spacing: 12,
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
        SizedBox(
          width: MediaQuery.widthOf(context) * 0.35,
          child: Consumer(
            builder: (context, ref, child) {
              return TextButton.icon(
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).signOut(),
                label: const Text('Log Out'),
                icon: const Icon(
                  Icons.logout,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
