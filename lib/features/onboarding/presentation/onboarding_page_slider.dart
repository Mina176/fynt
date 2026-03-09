import 'package:fintrack/features/onboarding/presentation/onboarding_card.dart';
import 'package:fintrack/features/onboarding/presentation/slider_index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingPageSlider extends StatelessWidget {
  const OnboardingPageSlider({
    super.key,
    required this.onSlide,
    required this.currentPage,
    required this.pageController,
  });

  final void Function(int)? onSlide;
  final int currentPage;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.58,
          child: PageView(
            onPageChanged: onSlide,
            controller: pageController,
            children: const [
              OnboardingCard(
                width: 180,
                height: 180,
                title: 'Financial Freedom',
                subTitle:
                    'Track your spending, save more, and achieve financial freedom.',
                icon: FontAwesomeIcons.chartSimple,
                borderRadius: 128,
              ),
              OnboardingCard(
                width: 180,
                height: 180,
                title: 'Smart Categorization',
                subTitle:
                    'Automatically categorize your transactions for effortless tracking.',
                icon: FontAwesomeIcons.chartPie,
                borderRadius: 32,
              ),
              OnboardingCard(
                width: 180,
                height: 180,
                title: 'Master your Monthly Budget',
                subTitle:
                    'Set your first budget and start saving today! Track every expense and watch your savings grow.',
                icon: Icons.account_balance_wallet_rounded,
                borderRadius: 32,
              ),
            ],
          ),
        ),
        SliderIndex(
          currentPage: currentPage,
        ),
      ],
    );
  }
}
