/// Screen names for `AnalyticsService.logScreenView`.
///
/// One per screen that exists, named like its route.
abstract final class AnalyticsScreens {
  /// Home tab.
  static const String home = 'home';

  /// Transactions tab.
  static const String transactions = 'transactions';

  /// Budget tab.
  static const String budget = 'budget';

  /// Recurring items tab.
  static const String recurring = 'recurring';

  /// Register-transaction screen.
  static const String newTransaction = 'new_transaction';
}

/// Event names for `AnalyticsService.logEvent`.
///
/// Convention: `<object>_<past verb>` in snake_case English, for example
/// `transaction_created`. Add each event in the sprint that first records
/// it; do not add events nobody logs yet.
abstract final class AnalyticsEvents {}

final RegExp _namePattern = RegExp(r'^[a-z][a-z0-9_]{0,39}$');

/// Whether [name] follows the naming convention: snake_case, starts with a
/// letter, at most 40 characters. Applies to events, screens and parameter
/// keys.
bool isValidAnalyticsName(String name) => _namePattern.hasMatch(name);
