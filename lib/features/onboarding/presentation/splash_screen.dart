import 'package:fintrack/features/authentication/logic/auth_service.dart';
import 'package:fintrack/features/onboarding/data/onboarding_repository.dart';
import 'package:fintrack/routing/app_route_enum.dart';
import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/features/onboarding/presentation/onboarding_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.1, end: 1.0),
          curve: Curves.linear,
          duration: const Duration(seconds: 2),
          builder: (context, opacity, child) {
            return Opacity(
              opacity: opacity,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OnboardingCard(
                    width: 120,
                    height: 120,
                    title: 'FinTrack',
                    subTitle: 'Master your money',
                    icon: Icons.account_balance_wallet,
                    borderRadius: Sizes.p24,
                  ),
                ],
              ),
            );
          },
          onEnd: () {
            final user = ref.read(authServiceProvider).currentUser;
            final onboardingCompleted = ref
                .read(onboardingRepositoryProvider)
                .isOnboardingCompleted;
            if (user != null) {
              context.go(AppRoutes.home.path);
            } else if (onboardingCompleted) {
              context.go(AppRoutes.signIn.path);
            } else {
              context.go(AppRoutes.onboarding.path);
            }
          },
        ),
      ),
    );
  }
}
