import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/constants/text_styles.dart';
import 'package:fintrack/features/authentication/logic/auth_controller.dart';
import 'package:fintrack/features/authentication/logic/auth_service.dart';
import 'package:fintrack/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authServiceProvider).currentUser;
    final String? photoUrl = currentUser?.avatarUrl;
    final bool hasValidPhoto =
        photoUrl != null && photoUrl.startsWith('https://');

    return Row(
      children: [
        GestureDetector(
          onTap: () => ref.read(authControllerProvider.notifier).signOut(),
          child: CircleAvatar(
            radius: 24,
            backgroundImage: hasValidPhoto
                ? NetworkImage(photoUrl)
                : NetworkImage(
                    'https://media.istockphoto.com/id/1288129985/vector/missing-image-of-a-person-placeholder.jpg?s=612x612&w=0&k=20&c=9kE777krx5mrFHsxx02v60ideRWvIgI1RWzR1X4MG2Y=',
                  ),
          ),
        ),
        gapW8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WELCOME BACK',
              style: TextStyles.subtitle.copyWith(fontSize: 14),
            ),
            Text(
              getUsernameWithId(ref),
              style: TextStyles.title.copyWith(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
