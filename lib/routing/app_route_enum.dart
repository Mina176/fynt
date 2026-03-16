enum AppRoutes {
  splash,
  onboarding,
  signIn,
  signUp,
  home,
  allTransactions,
  forgotPassword,
  updatePassword,
  profile,
  addTransaction,
  chooseCategory,
  addAccount,
  selectAccount,
  addBudget,
  setAppearance,
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.splash:
        return '/';
      case AppRoutes.onboarding:
        return '/onboarding';
      case AppRoutes.signIn:
        return '/signin';
      case AppRoutes.signUp:
        return '/signup';
      case AppRoutes.forgotPassword:
        return '/forgotPassword';
      case AppRoutes.updatePassword:
        return '/updatePassword';
      case AppRoutes.home:
        return '/home';
      case AppRoutes.allTransactions:
        return '/transactions';
      case AppRoutes.profile:
        return '/profile';
      case AppRoutes.addTransaction:
        return '/addTransaction';
      case AppRoutes.chooseCategory:
        return '/chooseCategory';
      case AppRoutes.addAccount:
        return '/addAccount';
      case AppRoutes.selectAccount:
        return '/selectAccount';
      case AppRoutes.addBudget:
        return '/addBudget';
      case AppRoutes.setAppearance:
        return '/setAppearance';
    }
  }
}
