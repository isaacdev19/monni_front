import 'dart:ui';

import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/wcag.dart';

/// Minimum contrast for normal text (WCAG AA).
const double minTextContrast = 4.5;

void main() {
  group('contrastRatio', () {
    test('black on white is 21:1', () {
      expect(
        contrastRatio(const Color(0xFF000000), const Color(0xFFFFFFFF)),
        closeTo(21, 0.001),
      );
    });

    test('a color on itself is 1:1', () {
      expect(
        contrastRatio(const Color(0xFF2E6B4D), const Color(0xFF2E6B4D)),
        closeTo(1, 0.001),
      );
    });

    test('order of the colors does not matter', () {
      const a = Color(0xFF22251F);
      const b = Color(0xFFF8F7F2);
      expect(contrastRatio(a, b), contrastRatio(b, a));
    });
  });

  group('text pairs reach $minTextContrast:1', () {
    const colors = MonniColors.light;

    // Table "Contrastes que deben probarse" in docs/design-tokens.md.
    final pairs = <String, (Color text, Color background)>{
      'text/primary on bg/app': (colors.text.primary, colors.bg.app),
      'text/secondary on bg/app': (colors.text.secondary, colors.bg.app),
      'text/tertiary on bg/app': (colors.text.tertiary, colors.bg.app),
      'brand/green on bg/app': (colors.brand.green, colors.bg.app),
      'status/danger-text on bg/app': (colors.status.dangerText, colors.bg.app),
      'status/danger-text on brand/coral-soft': (
        colors.status.dangerText,
        colors.brand.coralSoft,
      ),
      'text/inverse on status/expense': (
        colors.text.inverse,
        colors.status.expense,
      ),
      'text/inverse on status/income': (
        colors.text.inverse,
        colors.status.income,
      ),
      'brand/green on tone/green-bg': (
        colors.brand.green,
        colors.tone.green.bg,
      ),
      'brand/green on brand/green-soft': (
        colors.brand.green,
        colors.brand.greenSoft,
      ),
    };

    for (final MapEntry(key: name, value: (text, background))
        in pairs.entries) {
      test(name, () {
        final ratio = contrastRatio(text, background);
        expect(
          ratio,
          greaterThanOrEqualTo(minTextContrast),
          reason: '$name is ${ratio.toStringAsFixed(2)}:1',
        );
      });
    }
  });
}
