import 'package:app/src/entitlements/always_premium_entitlement_service.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The entitlement service.
///
/// Typed as [EntitlementService] so readers depend on the interface only,
/// never on the implementation.
final Provider<EntitlementService> entitlementServiceProvider =
    Provider<EntitlementService>(
      (ref) => const AlwaysPremiumEntitlementService(),
    );
