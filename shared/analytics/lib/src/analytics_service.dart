/// Records what the user does, for product analytics.
///
/// Code logs only through this interface, never through an implementation.
///
/// PRIVACY: parameters never carry amounts, notes or category names, nor
/// anything else the user typed. Only ids, enums, counts and flags.
///
/// Calls are fire-and-forget: they return nothing, and a failing
/// implementation must never break the caller.
abstract interface class AnalyticsService {
  /// Records the event [name] (see `AnalyticsEvents`) with simple
  /// [parameters]: String, int, double or bool values only.
  ///
  /// Names and parameter keys are snake_case in English, start with a
  /// letter and have at most 40 characters.
  void logEvent(String name, {Map<String, Object> parameters = const {}});

  /// Records that the screen [screenName] (see `AnalyticsScreens`) was
  /// shown.
  void logScreenView(String screenName);
}
