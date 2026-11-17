import 'package:core/core.dart';
import 'package:test/test.dart';

void main() {
  group('Money', () {
    test('keeps whole pesos', () {
      expect(const Money(1344400).pesos, 1344400);
    });

    test('zero is zero', () {
      expect(Money.zero.pesos, 0);
      expect(Money.zero.isZero, isTrue);
      expect(Money.zero.isPositive, isFalse);
      expect(Money.zero.isNegative, isFalse);
    });

    test('sign helpers', () {
      expect(const Money(1).isPositive, isTrue);
      expect(const Money(-1).isNegative, isTrue);
      expect(const Money(-1).isZero, isFalse);
    });

    test('maxPesos has 15 digits and stays below 2^53', () {
      expect(Money.maxPesos, 999999999999999);
      expect(Money.maxPesos < 9007199254740992, isTrue);
    });

    test('equality and hashCode by value', () {
      expect(const Money(500), equals(const Money(500)));
      expect(const Money(500).hashCode, const Money(500).hashCode);
      expect(const Money(500), isNot(equals(const Money(501))));
    });

    test('addition and subtraction', () {
      expect(const Money(1000) + const Money(344400), const Money(345400));
      expect(const Money(1000) - const Money(400), const Money(600));
    });

    test('subtraction can go negative (month available)', () {
      expect(const Money(100) - const Money(250), const Money(-150));
    });

    test('unary minus', () {
      expect(-const Money(500), const Money(-500));
    });

    test('multiplication by an int', () {
      expect(const Money(120000) * 3, const Money(360000));
      expect(const Money(120000) * 0, Money.zero);
    });

    test('comparison operators', () {
      const small = Money(100);
      const big = Money(200);
      expect(small < big, isTrue);
      expect(big > small, isTrue);
      expect(small <= const Money(100), isTrue);
      expect(big >= const Money(200), isTrue);
      expect(big < small, isFalse);
    });

    test('compareTo sorts by pesos', () {
      final list = [const Money(300), const Money(-5), const Money(100)]
        ..sort();
      expect(list, [const Money(-5), const Money(100), const Money(300)]);
    });

    test('sum of many amounts', () {
      expect(
        Money.sum([const Money(1000), const Money(2000), const Money(3)]),
        const Money(3003),
      );
    });

    test('sum of nothing is zero', () {
      expect(Money.sum(const <Money>[]), Money.zero);
    });

    test('large amounts stay exact', () {
      expect(
        const Money(Money.maxPesos) - const Money(1),
        const Money(999999999999998),
      );
    });

    test('toString shows pesos', () {
      expect(const Money(1344400).toString(), 'Money(1344400)');
    });
  });
}
