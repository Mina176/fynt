import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/core/constants/text_styles.dart';
import 'package:fynt/features/authentication/logic/auth_service.dart';
import 'package:fynt/core/utils/helpers.dart';
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

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: hasValidPhoto
                ? NetworkImage(photoUrl)
                : const NetworkImage(
                    'https://media.istockphoto.com/id/1288129985/vector/missing-image-of-a-person-placeholder.jpg?s=612x612&w=0&k=20&c=9kE777krx5mrFHsxx02v60ideRWvIgI1RWzR1X4MG2Y=',
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
      ),
    );
  }
}
