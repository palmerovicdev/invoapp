// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get about => 'About';

  @override
  String get close => 'Close';

  @override
  String get retry => 'Retry';

  @override
  String get logout => 'Logout';

  @override
  String get doYouWantToLogout => 'Do you want to logout?';

  @override
  String get requestFailed => 'Request failed.';

  @override
  String get pleaseCheckYourConnection =>
      'Please check your internet connection.';

  @override
  String get transactions => 'Transactions';

  @override
  String get youHaveNoInvoices => 'You have no invoices.';

  @override
  String get aboutApp => 'About App';

  @override
  String get themeColor => 'Theme Color';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get invoApp => 'InvoApp';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get incorrectEmailOrPassword => 'Incorrect email or password';

  @override
  String get signIn => 'Sign In';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get dontHaveAnAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get emailInvalid => 'Email is invalid';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password is too short';

  @override
  String get loginRequired => 'Login is required';

  @override
  String get authenticationFailed => 'Authentication failed';

  @override
  String get invalidCredentials => 'Invalid credentials';

  @override
  String get serverError => 'Server error';

  @override
  String get networkError => 'Network error';

  @override
  String get unexpectedError => 'Unexpected error';

  @override
  String get authenticationError => 'Authentication error';

  @override
  String get checkingAuth => 'Checking authentication...';

  @override
  String get loading => 'Loading...';

  @override
  String get lastUpdated => 'Last updated';

  @override
  String get justNow => 'Just now';

  @override
  String lastDays(int days) {
    return 'Last $days days';
  }

  @override
  String get invoices => 'Invoices';

  @override
  String get send => 'Send';

  @override
  String get received => 'Received';

  @override
  String get cancel => 'Cancel';

  @override
  String get search => 'Search';

  @override
  String get noResults => 'No results found';

  @override
  String get paid => 'Paid';

  @override
  String get awaitingPayment => 'Awaiting Payment';

  @override
  String get overdue => 'Overdue';

  @override
  String get draft => 'Draft';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get issued => 'Issued';

  @override
  String get due => 'Due';

  @override
  String get reference => 'Reference';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get tax => 'Tax';

  @override
  String get total => 'Total';

  @override
  String get retryWithoutFilters => 'Retry without filters';
}
