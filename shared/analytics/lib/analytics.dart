/// Analytics interface, its names and its implementations: an empty one
/// for release and a console one for debug.
library;

export 'src/analytics_names.dart' show AnalyticsEvents, AnalyticsScreens;
export 'src/analytics_service.dart';
export 'src/console_analytics_service.dart';
export 'src/noop_analytics_service.dart';
