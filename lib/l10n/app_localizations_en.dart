// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FinTrack';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get startTrackingToday => 'Start Tracking Today';

  @override
  String get takeControlOfFinances => 'Take control of your finances.';

  @override
  String get signUp => 'Sign Up';

  @override
  String get continueWith => 'Or continue with';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get forgotPasswordDescription =>
      'Don\'t worry, it happens. Please enter the email address associated with your account.';

  @override
  String get resetLinkSent => 'Reset link sent! Please check your email.';

  @override
  String get totalBalance => 'Total Balance';

  @override
  String get totalSpentThisWeek => 'Total spent this week';

  @override
  String vsLastMonth(Object percentage) {
    return '$percentage% vs last month';
  }

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again.';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get viewAll => 'View All';

  @override
  String get addAccount => 'Add Account';

  @override
  String get accountType => 'Account Type';

  @override
  String get accountName => 'Account Name';

  @override
  String get accountBalance => 'Account Balance';

  @override
  String get includeInNetWorth => 'Include in Net Worth';

  @override
  String get selectAccount => 'Select Account';

  @override
  String get addTransaction => 'Add Transaction';

  @override
  String get amount => 'Amount';

  @override
  String get category => 'Category';

  @override
  String get note => 'Note';

  @override
  String get date => 'Date';

  @override
  String get expense => 'Expense';

  @override
  String get income => 'Income';

  @override
  String get addBudget => 'Add Budget';

  @override
  String get budgetName => 'Budget Name';

  @override
  String get budgetNameHint => 'e.g. Monthly Groceries';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Log out';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get currency => 'Currency';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'john@example.com';

  @override
  String get passwordHint => '••••••••';

  @override
  String get fullName => 'Full Name';

  @override
  String get fullNameHint => 'John Doe';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get done => 'Done';

  @override
  String get loading => 'Loading...';

  @override
  String get errorEmailRequired => 'Email is required!';

  @override
  String get errorInvalidEmail => 'Invalid email address!';

  @override
  String get errorPasswordRequired => 'Password is required!';

  @override
  String get errorPasswordTooShort =>
      'Password must be at least 6 characters long!';

  @override
  String get errorConfirmPasswordRequired => 'Please confirm password!';

  @override
  String get errorPasswordMismatch => 'Passwords do not match!';

  @override
  String get errorNameRequired => 'Name is required!';

  @override
  String get debitCard => 'Debit Card';

  @override
  String get creditCard => 'Credit Card';

  @override
  String get savingsAccount => 'Savings Account';

  @override
  String get checkingAccount => 'Checking Account';

  @override
  String get investmentAccount => 'Investment Account';

  @override
  String get food => 'Food';

  @override
  String get shopping => 'Shopping';

  @override
  String get utilities => 'Utilities';

  @override
  String get entertainment => 'Entertainment';

  @override
  String get transportation => 'Transportation';

  @override
  String get healthcare => 'Healthcare';

  @override
  String get education => 'Education';

  @override
  String get other => 'Other';

  @override
  String get monthly => 'Monthly';

  @override
  String get weekly => 'Weekly';

  @override
  String get yearly => 'Yearly';

  @override
  String get recurrenceDuration => 'Recurrence Duration';

  @override
  String get failedToAddTransaction => 'Failed to add transaction';

  @override
  String get failedToCreateBudget => 'Failed to create budget';

  @override
  String get failedToCreateAccount => 'Failed to create account';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signIn => 'Sign In';

  @override
  String get categories => 'Categories';

  @override
  String get getStarted => 'Get Started';

  @override
  String get chooseTheme => 'Choose Theme';

  @override
  String get customizeAppearance =>
      'Customize the look of your money tracker Select a theme to preview how your dashboard and transactions appear.';

  @override
  String get appPreferences => 'APP PREFERENCES';

  @override
  String get allTransactions => 'All Transactions';

  @override
  String get noTransactionsYet =>
      'No transactions yet. Start by adding your first transaction!';

  @override
  String get spending => 'Spending';

  @override
  String get updatePasswordTitle => 'Update Password';

  @override
  String get updatePasswordDescription => 'Please enter your new password.';

  @override
  String get enterNewPassword => 'Enter your new password';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get loginSubtitle =>
      'Track your wealth securely.\n Please log in to your account.';

  @override
  String get noAccountFoundWithEmail => 'No account found with this email';

  @override
  String get passwordIncorrect => 'Password is incorrect';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get home => 'Home';

  @override
  String get wallet => 'Wallet';

  @override
  String get budgets => 'Budgets';

  @override
  String get cleanAndBright => 'Clean and bright';

  @override
  String get easyOnEyes => 'Easy on the eyes';

  @override
  String get leftToSpend => 'LEFT TO SPEND';

  @override
  String get totalSpent => 'Total Spent';

  @override
  String get remaining => 'remaining';

  @override
  String get balanceAffectsTotalAssets => 'Balance will affect total assets';

  @override
  String get noAccountsFoundAddFirst =>
      'No accounts found. Please add account first.\n';

  @override
  String get goToAccounts => 'Go to Accounts';

  @override
  String get accountNameHintPersonal => 'e.g. My Savings';

  @override
  String get errorAccountNameRequired => 'Account name is required';

  @override
  String get errorAccountBalanceRequired => 'Account balance is required';

  @override
  String get errorValidNumber => 'Please enter a valid number';

  @override
  String get masterYourMoney => 'Master your money';

  @override
  String get onboardingTitleFreedom => 'Financial Freedom';

  @override
  String get onboardingSubtitleFreedom =>
      'Track your spending, save more, and achieve financial freedom.';

  @override
  String get onboardingTitleSmartCategorization => 'Smart Categorization';

  @override
  String get onboardingSubtitleSmartCategorization =>
      'Automatically categorize your transactions for effortless tracking.';

  @override
  String get onboardingTitleBudgetMaster => 'Master your Monthly Budget';

  @override
  String get onboardingSubtitleBudgetMaster =>
      'Set your first budget and start saving today! Track every expense and watch your savings grow.';

  @override
  String get addBudgetPrompt => 'Press the + button above to add a budget.';

  @override
  String get addTransactionPrompt =>
      'Press the + button below to add a transaction.';

  @override
  String amountWithCurrency(Object currencyCode) {
    return 'Amount ($currencyCode)';
  }

  @override
  String get weeklyResetInfo =>
      'The budget will reset automatically on Monday of every week.';

  @override
  String get monthlyResetInfo =>
      'The budget will reset automatically on 1st of every month.';

  @override
  String get yearlyResetInfo =>
      'The budget will reset automatically on 1st Jan of every year.';

  @override
  String get mondayShort => 'Mon';

  @override
  String get tuesdayShort => 'Tue';

  @override
  String get wednesdayShort => 'Wed';

  @override
  String get thursdayShort => 'Thu';

  @override
  String get fridayShort => 'Fri';

  @override
  String get saturdayShort => 'Sat';

  @override
  String get sundayShort => 'Sun';

  @override
  String get transport => 'Transport';

  @override
  String get bills => 'Bills';

  @override
  String get salary => 'Salary';

  @override
  String get freelance => 'Freelance';

  @override
  String get housing => 'Housing';

  @override
  String get health => 'Health';

  @override
  String get gifts => 'Gifts';

  @override
  String get others => 'Others';

  @override
  String get cashWallet => 'Cash Wallet';

  @override
  String get investment => 'Investment';

  @override
  String get selectAccountToContinue => 'Select Account';

  @override
  String get unnamedBudget => 'Unnamed Budget';
}
