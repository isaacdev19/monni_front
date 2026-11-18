import 'package:analytics/analytics.dart';
import 'package:app/src/analytics/analytics_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the provider delivers an AnalyticsService (console in debug)', () {
    final container = ProviderContainer.test();

    final service = container.read(analyticsServiceProvider);

    expect(service, isA<AnalyticsService>());
    // Tests run in debug mode.
    expect(service, isA<ConsoleAnalyticsService>());
  });

  test('release builds get the empty implementation', () {
    expect(analyticsServiceFor(debug: false), isA<NoopAnalyticsService>());
    expect(analyticsServiceFor(debug: true), isA<ConsoleAnalyticsService>());
  });
}
