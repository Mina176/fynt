import 'package:fynt/features/onboarding/data/onboarding_repository.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:fynt/core/constants/app_sizes.dart';
import 'package:fynt/features/onboarding/presentation/widgets/onboarding_page_slider.dart';
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
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.kVerticalPadding,
            horizontal: Sizes.kHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: completeOnboarding,
                  child: const Text('skip'),
                ),
              ),
              Expanded(
                child: OnboardingPageSlider(
                  currentPage: currentPage,
                  pageController: _pageController,
                  onSlide: (index) => setState(() {
                    currentPage = index;
                  }),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => setState(
                  () => currentPage < 2
                      ? _pageController.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear,
                        )
                      : completeOnboarding(),
                ),
                child: Text(currentPage < 2 ? 'Next' : 'Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
