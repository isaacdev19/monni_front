import 'package:core/core.dart';

/// MVP implementation of [EntitlementService]: every user is premium.
///
/// Lives in `app` on purpose: features depend on `core`, not on `app`, so
/// they can only reach the interface.
final class AlwaysPremiumEntitlementService implements EntitlementService {
  /// Creates the service.
  const AlwaysPremiumEntitlementService();

  @override
  bool get isPremium => true;
}
