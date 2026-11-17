import 'package:core/core.dart';
import 'package:test/test.dart';

/// Non-breaking space between the symbol and the number.
const nbsp = ' ';

void main() {
  const format = MoneyFormat();

  group('MoneyFormat.format', () {
    test('formats the reference amount as "\$ 1.344.400"', () {
      expect(format.format(const Money(1344400)), '\$${nbsp}1.344.400');
    });

    test('formats zero', () {
      expect(format.format(Money.zero), '\$${nbsp}0');
    });

    test('formats small amounts without grouping', () {
      expect(format.format(const Money(5)), '\$${nbsp}5');
      expect(format.format(const Money(999)), '\$${nbsp}999');
    });

    test('groups thousands with dots', () {
      expect(format.format(const Money(1000)), '\$${nbsp}1.000');
    });

    test('formats large amounts exactly', () {
      expect(
        format.format(const Money(1000000000000)),
        '\$${nbsp}1.000.000.000.000',
      );
      expect(
        format.format(const Money(Money.maxPesos)),
        '\$${nbsp}999.999.999.999.999',
      );
    });

    test('formats negative amounts with the sign first', () {
      expect(format.format(const Money(-50000)), '-\$${nbsp}50.000');
    });
  });

  group('MoneyFormat.parse accepts', () {
    final cases = <String, int>{
      '1.344.400': 1344400,
      '1344400': 1344400,
      '\$ 1.344.400': 1344400,
      '\$1.344.400': 1344400,
      '\$${nbsp}1.344.400': 1344400,
      '  1 344 400 ': 1344400,
      '1.000': 1000,
      '999': 999,
      '0': 0,
      '000': 0,
      '999.999.999.999.999': Money.maxPesos,
    };
    for (final MapEntry(key: input, value: pesos) in cases.entries) {
      test('"$input" -> $pesos', () {
        expect(format.parse(input), MoneyParsed(Money(pesos)));
      });
    }

    test('round-trips its own output', () {
      const money = Money(1344400);
      expect(format.parse(format.format(money)), const MoneyParsed(money));
    });
  });

  group('MoneyFormat.parse empty', () {
    for (final input in ['', '   ', '\$', ' \$ ', nbsp]) {
      test('"$input" is empty', () {
        expect(format.parse(input), const MoneyEmpty());
      });
    }
  });

  group('MoneyFormat.parse rejects', () {
    final cases = <String, MoneyParseError>{
      'abc': MoneyParseError.invalidCharacters,
      '12a': MoneyParseError.invalidCharacters,
      '1,5': MoneyParseError.invalidCharacters,
      '1.344,00': MoneyParseError.invalidCharacters,
      '-5': MoneyParseError.invalidCharacters,
      '5\$': MoneyParseError.invalidCharacters,
      '\$\$5': MoneyParseError.invalidCharacters,
      '1.34.400': MoneyParseError.badGrouping,
      '1.3444.00': MoneyParseError.badGrouping,
      '1344.400.': MoneyParseError.badGrouping,
      '.500': MoneyParseError.badGrouping,
      '500.': MoneyParseError.badGrouping,
      '1..000': MoneyParseError.badGrouping,
      '1000.000': MoneyParseError.badGrouping,
      '1000000000000000': MoneyParseError.tooLarge,
      '1.000.000.000.000.000': MoneyParseError.tooLarge,
      '99999999999999999999999999': MoneyParseError.tooLarge,
    };
    for (final MapEntry(key: input, value: error) in cases.entries) {
      test('"$input" -> ${error.name}', () {
        expect(format.parse(input), MoneyInvalid(error));
      });
    }
  });
}
