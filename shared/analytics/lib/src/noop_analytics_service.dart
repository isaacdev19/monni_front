import 'package:analytics/src/analytics_service.dart';

/// [AnalyticsService] that records nothing. Used in release builds.
final class NoopAnalyticsService implements AnalyticsService {
  /// Creates the service.
  const NoopAnalyticsService();

  @override
  void logEvent(String name, {Map<String, Object> parameters = const {}}) {}

  @override
  void logScreenView(String screenName) {}
}
