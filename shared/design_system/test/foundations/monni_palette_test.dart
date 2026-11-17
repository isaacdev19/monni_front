import 'package:design_system/design_system.dart';
import 'package:design_system/src/foundations/monni_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

String hex(Color color) =>
    '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

void main() {
  group('MonniPalette matches the 46 Figma variables', () {
    // Section 1 of docs/design-tokens.md.
    final tokens = <String, (Color, String)>{
      'text/primary': (MonniPalette.textPrimary, '#22251f'),
      'text/secondary': (MonniPalette.textSecondary, '#60645c'),
      'text/tertiary': (MonniPalette.textTertiary, '#6f736c'),
      'text/placeholder': (MonniPalette.textPlaceholder, '#b4b6af'),
      'text/strong-muted': (MonniPalette.textStrongMuted, '#61655e'),
      'text/sage': (MonniPalette.textSage, '#606e62'),
      'text/inverse': (MonniPalette.textInverse, '#ffffff'),
      'text/icon': (MonniPalette.textIcon, '#44483f'),
      'bg/app': (MonniPalette.bgApp, '#f8f7f2'),
      'bg/surface': (MonniPalette.bgSurface, '#ffffff'),
      'bg/nav': (MonniPalette.bgNav, '#fffffd'),
      'bg/sunken': (MonniPalette.bgSunken, '#edeee8'),
      'bg/field-icon': (MonniPalette.bgFieldIcon, '#f0f1ec'),
      'bg/track': (MonniPalette.bgTrack, '#e6e8e2'),
      'bg/control-off': (MonniPalette.bgControlOff, '#d7d9d3'),
      'bg/badge': (MonniPalette.bgBadge, '#dedfd9'),
      'bg/scrim': (MonniPalette.bgScrim, '#1b1f19'),
      'border/divider': (MonniPalette.borderDivider, '#e8e9e2'),
      'border/card': (MonniPalette.borderCard, '#ebebe5'),
      'border/control': (MonniPalette.borderControl, '#e2e3dd'),
      'border/selected': (MonniPalette.borderSelected, '#87a291'),
      'brand/green': (MonniPalette.brandGreen, '#2e6b4d'),
      'brand/green-card': (MonniPalette.brandGreenCard, '#2e674b'),
      'brand/green-soft': (MonniPalette.brandGreenSoft, '#dcebdd'),
      'brand/green-pale': (MonniPalette.brandGreenPale, '#e2eee3'),
      'brand/coral': (MonniPalette.brandCoral, '#dd725f'),
      'brand/coral-soft': (MonniPalette.brandCoralSoft, '#f8ded8'),
      'status/ok': (MonniPalette.statusOk, '#68a178'),
      'status/warn': (MonniPalette.statusWarn, '#d3ae4f'),
      'status/over': (MonniPalette.statusOver, '#dc705e'),
      'status/danger-text': (MonniPalette.statusDangerText, '#aa4334'),
      'status/expense': (MonniPalette.statusExpense, '#c1513e'),
      'status/income': (MonniPalette.statusIncome, '#527e62'),
      'tone/lilac-fg': (MonniPalette.toneLilacFg, '#76619b'),
      'tone/lilac-bg': (MonniPalette.toneLilacBg, '#eee9f6'),
      'tone/blue-fg': (MonniPalette.toneBlueFg, '#4f7390'),
      'tone/blue-bg': (MonniPalette.toneBlueBg, '#e3eef4'),
      'tone/yellow-fg': (MonniPalette.toneYellowFg, '#94752d'),
      'tone/yellow-bg': (MonniPalette.toneYellowBg, '#f5eccd'),
      'tone/green-fg': (MonniPalette.toneGreenFg, '#52755e'),
      'tone/green-bg': (MonniPalette.toneGreenBg, '#e3eee4'),
      'tone/mint-fg': (MonniPalette.toneMintFg, '#377059'),
      'tone/mint-bg': (MonniPalette.toneMintBg, '#dceee4'),
      'tone/coral-fg': (MonniPalette.toneCoralFg, '#b86252'),
      'tone/coral-bg': (MonniPalette.toneCoralBg, '#f7e2dc'),
      'chart/on-green': (MonniPalette.chartOnGreen, '#b9d7bd'),
    };

    test('there are 46 tokens', () {
      expect(tokens, hasLength(46));
    });

    for (final MapEntry(key: name, value: (color, expected))
        in tokens.entries) {
      test('$name is $expected and opaque', () {
        expect(hex(color), expected);
        expect(color.toARGB32() >> 24, 0xFF);
      });
    }
  });

  group('contrast fix of Nov 17, 2026', () {
    test('danger-text, expense and income use the darker values', () {
      expect(hex(MonniPalette.statusDangerText), '#aa4334');
      expect(hex(MonniPalette.statusExpense), '#c1513e');
      expect(hex(MonniPalette.statusIncome), '#527e62');
    });
  });

  group('MonniColors.light reads from MonniPalette', () {
    const colors = MonniColors.light;

    test('key roles', () {
      expect(colors.text.primary, MonniPalette.textPrimary);
      expect(colors.text.secondary, MonniPalette.textSecondary);
      expect(colors.bg.app, MonniPalette.bgApp);
      expect(colors.brand.green, MonniPalette.brandGreen);
      expect(colors.status.dangerText, MonniPalette.statusDangerText);
      expect(colors.status.expense, MonniPalette.statusExpense);
      expect(colors.status.income, MonniPalette.statusIncome);
      expect(
        colors.tone.green,
        const MonniTone(
          fg: MonniPalette.toneGreenFg,
          bg: MonniPalette.toneGreenBg,
        ),
      );
      expect(colors.chart.onGreen, MonniPalette.chartOnGreen);
    });
  });

  group('MonniColors as a ThemeExtension', () {
    test('lerp at 0 and 1 returns the ends', () {
      const other = MonniColors.light;
      final changed = MonniColors.light.copyWith(
        text: MonniColors.light.text.copyWith(primary: const Color(0xFF000000)),
      );
      expect(other.lerp(changed, 0), other);
      expect(other.lerp(changed, 1), changed);
    });

    test('copyWith with no arguments keeps every value', () {
      expect(MonniColors.light.copyWith(), MonniColors.light);
    });

    testWidgets('of(context) reads the extension from the theme', (
      tester,
    ) async {
      late MonniColors found;
      await tester.pumpWidget(
        Theme(
          data: ThemeData(extensions: const [MonniColors.light]),
          child: Builder(
            builder: (context) {
              found = MonniColors.of(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(found, MonniColors.light);
    });
  });
}
