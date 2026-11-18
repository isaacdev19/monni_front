/// Answers whether the user has premium access.
///
/// Code asks "is premium?" only through this interface, never through an
/// implementation. In the MVP every user is premium; the implementation
/// is chosen by `app`.
abstract interface class EntitlementService {
  /// Whether the user has premium access right now.
  bool get isPremium;
}
