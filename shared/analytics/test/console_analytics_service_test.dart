import 'package:analytics/analytics.dart';
import 'package:analytics/src/analytics_names.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late List<String?> written;
  late ConsoleAnalyticsService service;

  setUp(() {
    written = [];
    service = ConsoleAnalyticsService(
      printer: (message, {wrapWidth}) => written.add(message),
    );
  });

  test('writes the event name and its parameters', () {
    service.logEvent(
      'transaction_created',
      parameters: {'kind': 'expense', 'is_fixed': true},
    );

    expect(written, [
      '[analytics] event transaction_created {kind: expense, is_fixed: true}',
    ]);
  });

  test('writes an event without parameters', () {
    service.logEvent('transaction_created');

    expect(written, ['[analytics] event transaction_created']);
  });

  test('writes the screen view', () {
    service.logScreenView(AnalyticsScreens.home);

    expect(written, ['[analytics] screen home']);
  });

  test('asserts the naming convention', () {
    expect(
      () => service.logEvent('TransactionCreated'),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => service.logEvent('ok_name', parameters: {'Bad Key': 1}),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => service.logScreenView('new-transaction'),
      throwsA(isA<AssertionError>()),
    );
    expect(written, isEmpty);
  });

  test('asserts that parameter values are simple', () {
    expect(
      () => service.logEvent(
        'transaction_created',
        parameters: {
          'ids': ['a', 'b'],
        },
      ),
      throwsA(isA<AssertionError>()),
    );
  });

  group('naming convention', () {
    test('accepts snake_case names up to 40 characters', () {
      expect(isValidAnalyticsName('transaction_created'), isTrue);
      expect(isValidAnalyticsName('a${'b' * 39}'), isTrue);
    });

    test('rejects other shapes', () {
      for (final name in [
        '',
        'Home',
        '1st_screen',
        '_private',
        'new-transaction',
        'a${'b' * 40}',
      ]) {
        expect(isValidAnalyticsName(name), isFalse, reason: name);
      }
    });

    test('every screen constant follows it', () {
      const screens = [
        AnalyticsScreens.home,
        AnalyticsScreens.transactions,
        AnalyticsScreens.budget,
        AnalyticsScreens.recurring,
        AnalyticsScreens.newTransaction,
      ];
      for (final screen in screens) {
        expect(isValidAnalyticsName(screen), isTrue, reason: screen);
      }
      expect(screens.toSet(), hasLength(screens.length));
    });
  });
}
