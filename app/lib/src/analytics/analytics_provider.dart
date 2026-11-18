import 'package:analytics/analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The analytics service: console in debug, nothing in release.
///
/// Typed as [AnalyticsService] so readers depend on the interface only.
final Provider<AnalyticsService> analyticsServiceProvider =
    Provider<AnalyticsService>((ref) => analyticsServiceFor(debug: kDebugMode));

/// Picks the implementation for the build mode. Split out so tests can
/// cover both modes.
AnalyticsService analyticsServiceFor({required bool debug}) =>
    debug ? ConsoleAnalyticsService() : const NoopAnalyticsService();
