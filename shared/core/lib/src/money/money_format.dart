import 'package:core/src/money/money.dart';
import 'package:intl/intl.dart';

/// Formats and parses Colombian peso amounts, for example `$ 1.344.400`.
///
/// intl has no `es_CO` number data and falls back to `es` (Spain), which
/// writes `1.344.400 $`. A custom pattern keeps the Spanish dot grouping and
/// puts the symbol first, separated by a non-breaking space so it never wraps.
final class MoneyFormat {
  /// Creates the formatter. It holds no state.
  const MoneyFormat();

  static const String _symbol = r'$';
  static const String _nonBreakingSpace = '\u00A0';
  static const int _maxDigits = 15;

  static final NumberFormat _numberFormat = NumberFormat.currency(
    locale: 'es_CO',
    symbol: _symbol,
    decimalDigits: 0,
    customPattern: '¤$_nonBreakingSpace#,##0;-¤$_nonBreakingSpace#,##0',
  );

  static final RegExp _spaces = RegExp('[\\s$_nonBreakingSpace]');
  static final RegExp _digitsAndDots = RegExp(r'^[0-9.]+$');
  static final RegExp _groupedDigits = RegExp(r'^[0-9]{1,3}(\.[0-9]{3})+$');
  static final RegExp _leadingZeros = RegExp('^0+');

  /// Formats [money] as `$ 1.344.400`.
  String format(Money money) => _numberFormat.format(money.pesos);

  /// Parses what the user typed into an amount of pesos.
  ///
  /// Accepts an optional leading `$`, spaces anywhere and dots as thousands
  /// separators in valid groups of three. Never returns a negative amount.
  MoneyParseResult parse(String input) {
    var text = input.trim();
    if (text.startsWith(_symbol)) {
      text = text.substring(_symbol.length);
    }
    text = text.replaceAll(_spaces, '');

    if (text.isEmpty) {
      return const MoneyEmpty();
    }
    if (!_digitsAndDots.hasMatch(text)) {
      return const MoneyInvalid(MoneyParseError.invalidCharacters);
    }
    if (text.contains('.') && !_groupedDigits.hasMatch(text)) {
      return const MoneyInvalid(MoneyParseError.badGrouping);
    }

    final digits = text.replaceAll('.', '').replaceFirst(_leadingZeros, '');
    if (digits.isEmpty) {
      return const MoneyParsed(Money.zero);
    }
    // Checked before int.parse so a very long input can never overflow.
    if (digits.length > _maxDigits) {
      return const MoneyInvalid(MoneyParseError.tooLarge);
    }
    return MoneyParsed(Money(int.parse(digits)));
  }
}

/// Result of [MoneyFormat.parse].
sealed class MoneyParseResult {
  const MoneyParseResult();
}

/// The input was a valid amount.
final class MoneyParsed extends MoneyParseResult {
  /// Wraps the parsed [money].
  const MoneyParsed(this.money);

  /// The parsed amount. Never negative.
  final Money money;

  @override
  bool operator ==(Object other) =>
      other is MoneyParsed && other.money == money;

  @override
  int get hashCode => money.hashCode;

  @override
  String toString() => 'MoneyParsed($money)';
}

/// The input had nothing to parse (empty, only spaces or only `$`).
final class MoneyEmpty extends MoneyParseResult {
  /// Creates the empty result.
  const MoneyEmpty();

  @override
  bool operator ==(Object other) => other is MoneyEmpty;

  @override
  int get hashCode => (MoneyEmpty).hashCode;

  @override
  String toString() => 'MoneyEmpty()';
}

/// The input was not a valid amount.
final class MoneyInvalid extends MoneyParseResult {
  /// Wraps the reason the input was rejected.
  const MoneyInvalid(this.error);

  /// Why the input was rejected.
  final MoneyParseError error;

  @override
  bool operator ==(Object other) =>
      other is MoneyInvalid && other.error == error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'MoneyInvalid(${error.name})';
}

/// Why [MoneyFormat.parse] rejected an input.
enum MoneyParseError {
  /// Something other than digits, dots, spaces or a leading `$`.
  invalidCharacters,

  /// Dots that are not valid thousands separators, like `1.34.400`.
  badGrouping,

  /// More than 15 digits.
  tooLarge,
}
