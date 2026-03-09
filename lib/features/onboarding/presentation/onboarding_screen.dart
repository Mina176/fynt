import 'package:fintrack/features/onboarding/data/onboarding_repository.dart';
import 'package:fintrack/routing/app_route_enum.dart';
import 'package:fintrack/constants/app_sizes.dart';
import 'package:fintrack/features/onboarding/presentation/onboarding_page_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void completeOnboarding() async {
    await ref.read(onboardingRepositoryProvider).setOnboardingCompleted();
    if (mounted) {
      context.go(AppRoutes.signIn.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: completeOnboarding,
                child: const Text('skip'),
              ),
              const Spacer(),
              OnboardingPageSlider(
                currentPage: currentPage,
                pageController: _pageController,
                onSlide: (index) => setState(() {
                  currentPage = index;
                }),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => setState(() {
                  currentPage < 2
                      ? _pageController.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear,
                        )
                      : completeOnboarding();
                }),
                child: currentPage < 2
                    ? const Text('Next')
                    : ElevatedButton(
                        onPressed: completeOnboarding,
                        child: const Text('Get Started'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
