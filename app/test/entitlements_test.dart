import 'package:app/src/entitlements/always_premium_entitlement_service.dart';
import 'package:app/src/entitlements/entitlement_provider.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// A non-premium double, to show the provider is not tied to the MVP class.
final class _FreeEntitlementService implements EntitlementService {
  const _FreeEntitlementService();

  @override
  bool get isPremium => false;
}

void main() {
  test('the MVP implementation answers yes', () {
    expect(const AlwaysPremiumEntitlementService().isPremium, isTrue);
  });

  test('the provider delivers an EntitlementService that answers yes', () {
    final container = ProviderContainer.test();

    final service = container.read(entitlementServiceProvider);

    expect(service, isA<EntitlementService>());
    expect(service.isPremium, isTrue);
  });

  test('the provider can be overridden with another implementation', () {
    final container = ProviderContainer.test(
      overrides: [
        entitlementServiceProvider.overrideWithValue(
          const _FreeEntitlementService(),
        ),
      ],
    );

    expect(container.read(entitlementServiceProvider).isPremium, isFalse);
  });
}
