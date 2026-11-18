import 'package:analytics/analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Noop does not fail and writes nothing', () {
    final written = <String?>[];
    final original = debugPrint;
    debugPrint = (message, {wrapWidth}) => written.add(message);
    addTearDown(() => debugPrint = original);

    const service = NoopAnalyticsService();
    expect(() {
      service
        ..logEvent('transaction_created')
        ..logEvent('transaction_created', parameters: {'kind': 'expense'})
        ..logScreenView(AnalyticsScreens.home);
    }, returnsNormally);

    expect(written, isEmpty);
  });
}
