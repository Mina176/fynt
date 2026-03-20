import 'package:fynt/features/accounts/presentation/add_account_screen.dart';
import 'package:fynt/features/transactions/presentation/add_transaction_screen.dart';
import 'package:fynt/features/transactions/presentation/choose_category_screen.dart';
import 'package:fynt/features/transactions/presentation/select_account_screen.dart';
import 'package:fynt/features/authentication/logic/auth_service.dart';
import 'package:fynt/features/authentication/presentation/forgot_password_screen.dart';
import 'package:fynt/features/authentication/presentation/login_screen.dart';
import 'package:fynt/features/settings/settings_screen.dart';
import 'package:fynt/features/authentication/presentation/update_password_screen.dart';
import 'package:fynt/features/authentication/presentation/sign_up_screen.dart';
import 'package:fynt/features/budgets/presentation/add_budget_screen.dart';
import 'package:fynt/features/transactions/presentation/all_transactions_screen.dart';
import 'package:fynt/features/dashboard/root_dashboard.dart';
import 'package:fynt/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fynt/features/onboarding/presentation/splash_screen.dart';
import 'package:fynt/features/settings/appearance/presentation/set_appearance_screen.dart';
import 'package:fynt/core/routing/app_route_enum.dart';
import 'package:fynt/core/routing/refresh_listenable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authService = ref.watch(authServiceProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash.path,
    refreshListenable: GoRouterRefreshStream(authService.authStateChanges()),
    redirect: (context, state) {
      final isLoggedIn = authService.currentUser != null;

      final isLoginRoute = state.matchedLocation == AppRoutes.signIn.path;
      final isSignUpRoute = state.matchedLocation == AppRoutes.signUp.path;
      final isOnboarding = state.matchedLocation == AppRoutes.onboarding.path;
      final isForgotPassword =
          state.matchedLocation == AppRoutes.forgotPassword.path;
      final isUpdatePassword =
          state.matchedLocation == AppRoutes.updatePassword.path;
      final isSplash = state.matchedLocation == AppRoutes.splash.path;
      final isStrictAuthScreen =
          isLoginRoute || isSignUpRoute || isOnboarding || isForgotPassword;
      if (isSplash) return null;

      if (!isLoggedIn) {
        if (isStrictAuthScreen || isUpdatePassword) return null;
        return AppRoutes.signIn.path;
      }

      if (isLoggedIn) {
        if (isStrictAuthScreen) return AppRoutes.home.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding.path,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp.path,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.signIn.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword.path,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.updatePassword.path,
        builder: (context, state) => const UpdatePasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings.path,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.home.path,
        builder: (context, state) => const RootHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.allTransactions.path,
        builder: (context, state) => const AllTransactionsScreen(),
      ),
      GoRoute(
        path: AppRoutes.addTransaction.path,
        builder: (context, state) => const AddTransactionScreen(),
      ),
      GoRoute(
        path: AppRoutes.chooseCategory.path,
        builder: (context, state) {
          final expenseOrIncome = (state.extra as int?) ?? 0;
          return ChooseCategoryScreen(expenseOrIncome: expenseOrIncome);
        },
      ),
      GoRoute(
        path: AppRoutes.addAccount.path,
        builder: (context, state) => const AddAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.selectAccount.path,
        builder: (context, state) => const SelectAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.addBudget.path,
        builder: (context, state) => const AddBudgetScreen(),
      ),
      GoRoute(
        path: AppRoutes.setAppearance.path,
        builder: (context, state) => const SetAppearanceScreen(),
      ),
    ],
  );
});
