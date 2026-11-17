/// An amount of Colombian pesos.
///
/// Always whole pesos stored as an [int]. Never use double for money.
/// The value can be negative so it can hold balances such as the month
/// available (income minus expenses). Rules like "a transaction amount is
/// always greater than zero" belong to the feature that owns that data.
final class Money implements Comparable<Money> {
  /// Creates an amount of [pesos].
  const Money(this.pesos);

  /// Zero pesos.
  static const Money zero = Money(0);

  /// Largest amount the app accepts from user input: 15 digits.
  ///
  /// It stays below 2^53, so it is also exact when compiled to JavaScript.
  static const int maxPesos = 999999999999999;

  /// The amount in whole pesos.
  final int pesos;

  /// Whether the amount is exactly zero.
  bool get isZero => pesos == 0;

  /// Whether the amount is greater than zero.
  bool get isPositive => pesos > 0;

  /// Whether the amount is less than zero.
  bool get isNegative => pesos < 0;

  /// Adds two amounts.
  Money operator +(Money other) => Money(pesos + other.pesos);

  /// Subtracts [other]. The result can be negative.
  Money operator -(Money other) => Money(pesos - other.pesos);

  /// The same amount with the opposite sign.
  Money operator -() => Money(-pesos);

  /// Multiplies the amount by a whole number of [times].
  Money operator *(int times) => Money(pesos * times);

  /// Whether this amount is less than [other].
  bool operator <(Money other) => pesos < other.pesos;

  /// Whether this amount is greater than [other].
  bool operator >(Money other) => pesos > other.pesos;

  /// Whether this amount is less than or equal to [other].
  bool operator <=(Money other) => pesos <= other.pesos;

  /// Whether this amount is greater than or equal to [other].
  bool operator >=(Money other) => pesos >= other.pesos;

  /// Adds all [amounts]. An empty list gives [zero].
  static Money sum(Iterable<Money> amounts) =>
      amounts.fold(zero, (total, amount) => total + amount);

  @override
  int compareTo(Money other) => pesos.compareTo(other.pesos);

  @override
  bool operator ==(Object other) => other is Money && other.pesos == pesos;

  @override
  int get hashCode => pesos.hashCode;

  @override
  String toString() => 'Money($pesos)';
}
