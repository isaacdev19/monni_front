import 'package:analytics/src/analytics_names.dart';
import 'package:analytics/src/analytics_service.dart';
import 'package:flutter/foundation.dart';

/// [AnalyticsService] that writes each call to the console, in debug
/// builds only.
///
/// Output: `[analytics] event transaction_created {kind: expense}` and
/// `[analytics] screen home`. In debug it also asserts the naming
/// convention and that parameter values are simple.
final class ConsoleAnalyticsService implements AnalyticsService {
  /// Creates the service. `printer` defaults to [debugPrint]; tests pass
  /// their own to read the output.
  ConsoleAnalyticsService({this._printer});

  final DebugPrintCallback? _printer;

  @override
  void logEvent(String name, {Map<String, Object> parameters = const {}}) {
    assert(isValidAnalyticsName(name), 'Bad analytics event name: "$name".');
    assert(
      parameters.keys.every(isValidAnalyticsName),
      'Bad analytics parameter key in $parameters.',
    );
    assert(
      parameters.values.every((v) => v is String || v is num || v is bool),
      'Analytics parameter values must be String, num or bool: $parameters.',
    );
    _write(parameters.isEmpty ? 'event $name' : 'event $name $parameters');
  }

  @override
  void logScreenView(String screenName) {
    assert(
      isValidAnalyticsName(screenName),
      'Bad analytics screen name: "$screenName".',
    );
    _write('screen $screenName');
  }

  void _write(String message) {
    if (!kDebugMode) return;
    (_printer ?? debugPrint)('[analytics] $message');
  }
}
