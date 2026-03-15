import 'package:fintrack/features/accounts/presentation/add_account_screen.dart';
import 'package:fintrack/features/add_transaction/presentation/add_transaction.dart';
import 'package:fintrack/features/add_transaction/presentation/choose_category_screen.dart';
import 'package:fintrack/features/add_transaction/presentation/select_account_screen.dart';
import 'package:fintrack/features/authentication/logic/auth_service.dart';
import 'package:fintrack/features/authentication/presentation/forgot_password_screen.dart';
import 'package:fintrack/features/authentication/presentation/login_screen.dart';
import 'package:fintrack/features/authentication/presentation/profile_screen.dart';
import 'package:fintrack/features/authentication/presentation/sign_up_screen.dart';
import 'package:fintrack/features/budgets/presentation/add_budget_screen.dart';
import 'package:fintrack/features/home_screen/presentation/all_transactions_screen.dart';
import 'package:fintrack/features/home_screen/presentation/root_home.dart';
import 'package:fintrack/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fintrack/features/onboarding/presentation/splash_screen.dart';
import 'package:fintrack/features/appearance/presentation/set_appearance_screen.dart';
import 'package:fintrack/routing/app_route_enum.dart';
import 'package:fintrack/routing/refresh_listenable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
      final isResetPassword = state.matchedLocation == AppRoutes.profile.path;
      final isSplash = state.matchedLocation == AppRoutes.splash.path;

      // If NOT logged in, but trying to access Home -> Redirect to Login

      if (!isLoggedIn) {
        if (isLoginRoute ||
            isSignUpRoute ||
            isOnboarding ||
            isForgotPassword ||
            isResetPassword ||
            isSplash) {
          return null;
        }
        return AppRoutes.signIn.path;
      }

      // If LOGGED IN, but sitting on Login/SignUp -> Redirect to Home
      if (isLoggedIn) {
        if (isLoginRoute ||
            isSignUpRoute ||
            isOnboarding ||
            isForgotPassword ||
            isResetPassword) {
          return AppRoutes.home.path;
        }
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
        path: AppRoutes.profile.path,
        builder: (context, state) => const ProfileScreen(),
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
        builder: (context, state) => const ChooseCategoryScreen(),
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
