import 'package:design_system/design_system.dart';
import 'package:design_system/src/foundations/monni_palette.dart';
import 'package:design_system/src/foundations/monni_shadows.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/wcag.dart';

void main() {
  final theme = MonniTheme.light();
  final scheme = theme.colorScheme;

  group('ThemeData', () {
    test('is Material 3 and light', () {
      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
    });

    test('scaffold background is bg/app', () {
      expect(theme.scaffoldBackgroundColor, MonniPalette.bgApp);
    });

    test('registers the color and shadow extensions', () {
      expect(theme.extension<MonniColors>(), MonniColors.light);
      expect(theme.extension<MonniShadowTheme>(), MonniShadowTheme.light);
    });
  });

  group('ColorScheme slots map to tokens', () {
    final slots = <String, (Color slot, Color token)>{
      'primary': (scheme.primary, MonniPalette.brandGreen),
      'onPrimary': (scheme.onPrimary, MonniPalette.textInverse),
      'primaryContainer': (
        scheme.primaryContainer,
        MonniPalette.brandGreenSoft,
      ),
      'onPrimaryContainer': (
        scheme.onPrimaryContainer,
        MonniPalette.brandGreen,
      ),
      'secondary': (scheme.secondary, MonniPalette.brandCoral),
      'onSecondary': (scheme.onSecondary, MonniPalette.textPrimary),
      'secondaryContainer': (
        scheme.secondaryContainer,
        MonniPalette.brandCoralSoft,
      ),
      'onSecondaryContainer': (
        scheme.onSecondaryContainer,
        MonniPalette.statusDangerText,
      ),
      'error': (scheme.error, MonniPalette.statusDangerText),
      'onError': (scheme.onError, MonniPalette.textInverse),
      'errorContainer': (scheme.errorContainer, MonniPalette.brandCoralSoft),
      'onErrorContainer': (
        scheme.onErrorContainer,
        MonniPalette.statusDangerText,
      ),
      'surface': (scheme.surface, MonniPalette.bgSurface),
      'onSurface': (scheme.onSurface, MonniPalette.textPrimary),
      'onSurfaceVariant': (scheme.onSurfaceVariant, MonniPalette.textSecondary),
      'surfaceBright': (scheme.surfaceBright, MonniPalette.bgSurface),
      'surfaceDim': (scheme.surfaceDim, MonniPalette.bgSunken),
      'surfaceContainerLowest': (
        scheme.surfaceContainerLowest,
        MonniPalette.bgSurface,
      ),
      'surfaceContainerLow': (scheme.surfaceContainerLow, MonniPalette.bgApp),
      'surfaceContainer': (scheme.surfaceContainer, MonniPalette.bgFieldIcon),
      'surfaceContainerHigh': (
        scheme.surfaceContainerHigh,
        MonniPalette.bgSunken,
      ),
      'surfaceContainerHighest': (
        scheme.surfaceContainerHighest,
        MonniPalette.bgTrack,
      ),
      'outline': (scheme.outline, MonniPalette.borderControl),
      'outlineVariant': (scheme.outlineVariant, MonniPalette.borderDivider),
      'shadow': (scheme.shadow, MonniPalette.bgScrim),
      'scrim': (scheme.scrim, MonniPalette.bgScrim),
      'inverseSurface': (scheme.inverseSurface, MonniPalette.textPrimary),
      'onInverseSurface': (scheme.onInverseSurface, MonniPalette.bgApp),
      'inversePrimary': (scheme.inversePrimary, MonniPalette.chartOnGreen),
      'surfaceTint': (scheme.surfaceTint, Colors.transparent),
    };

    for (final MapEntry(key: name, value: (slot, token)) in slots.entries) {
      test(name, () => expect(slot, token));
    }
  });

  group('ColorScheme text pairs reach 4.5:1', () {
    final pairs = <String, (Color text, Color background)>{
      'onPrimary on primary': (scheme.onPrimary, scheme.primary),
      'onPrimaryContainer on primaryContainer': (
        scheme.onPrimaryContainer,
        scheme.primaryContainer,
      ),
      'onSecondary on secondary': (scheme.onSecondary, scheme.secondary),
      'onSecondaryContainer on secondaryContainer': (
        scheme.onSecondaryContainer,
        scheme.secondaryContainer,
      ),
      'onError on error': (scheme.onError, scheme.error),
      'onErrorContainer on errorContainer': (
        scheme.onErrorContainer,
        scheme.errorContainer,
      ),
      'onSurface on surface': (scheme.onSurface, scheme.surface),
      'onSurfaceVariant on surface': (scheme.onSurfaceVariant, scheme.surface),
      'onSurfaceVariant on surfaceContainerHigh': (
        scheme.onSurfaceVariant,
        scheme.surfaceContainerHigh,
      ),
      'onInverseSurface on inverseSurface': (
        scheme.onInverseSurface,
        scheme.inverseSurface,
      ),
      'inversePrimary on inverseSurface': (
        scheme.inversePrimary,
        scheme.inverseSurface,
      ),
    };

    for (final MapEntry(key: name, value: (text, background))
        in pairs.entries) {
      test(name, () {
        final ratio = contrastRatio(text, background);
        expect(
          ratio,
          greaterThanOrEqualTo(4.5),
          reason: '$name is ${ratio.toStringAsFixed(2)}:1',
        );
      });
    }
  });

  group('TextTheme slots map to Figma styles', () {
    const text = MonniTheme.textTheme;
    final slots = <String, (TextStyle?, TextStyle)>{
      'displayLarge': (text.displayLarge, MonniTypography.displayAmount),
      'displayMedium': (text.displayMedium, MonniTypography.displayBalance),
      'displaySmall': (text.displaySmall, MonniTypography.displayBudget),
      'headlineLarge': (text.headlineLarge, MonniTypography.headingPage),
      'headlineMedium': (text.headlineMedium, MonniTypography.headingSheet),
      'headlineSmall': (text.headlineSmall, MonniTypography.headingSection),
      'titleLarge': (text.titleLarge, MonniTypography.headingEmpty),
      'titleMedium': (text.titleMedium, MonniTypography.titleItem),
      'titleSmall': (text.titleSmall, MonniTypography.labelMd),
      'bodyLarge': (text.bodyLarge, MonniTypography.bodyLg),
      'bodyMedium': (text.bodyMedium, MonniTypography.bodySm),
      'bodySmall': (text.bodySmall, MonniTypography.bodyMd),
      'labelLarge': (text.labelLarge, MonniTypography.buttonPrimary),
      'labelMedium': (text.labelMedium, MonniTypography.labelMd),
      'labelSmall': (text.labelSmall, MonniTypography.labelSm),
    };

    for (final MapEntry(key: name, value: (slot, style)) in slots.entries) {
      test(name, () => expect(identical(slot, style), isTrue));
    }

    test('ThemeData keeps family, size and weight, and adds a color', () {
      final body = theme.textTheme.bodyMedium!;
      expect(body.fontFamily, 'packages/design_system/Inter');
      expect(body.fontSize, 12);
      expect(body.fontWeight, FontWeight.w400);
      expect(body.color, MonniPalette.textPrimary);
    });
  });

  group('MonniShadowTheme', () {
    test('light uses the six shadow tokens', () {
      const s = MonniShadowTheme.light;
      expect(s.card, MonniShadows.card);
      expect(s.raised, MonniShadows.raised);
      expect(s.button, MonniShadows.button);
      expect(s.selected, MonniShadows.selected);
      expect(s.segment, MonniShadows.segment);
      expect(s.sheet, MonniShadows.sheet);
    });

    test('copyWith with no arguments keeps every value', () {
      expect(MonniShadowTheme.light.copyWith(), MonniShadowTheme.light);
    });

    test('lerp at 0 and 1 returns the ends', () {
      const a = MonniShadowTheme.light;
      final b = a.copyWith(card: MonniShadows.sheet);
      expect(a.lerp(b, 0), a);
      expect(a.lerp(b, 1), b);
    });
  });

  group('with the theme applied', () {
    Future<BuildContext> pumpApp(WidgetTester tester, Widget child) async {
      late BuildContext captured;
      await tester.pumpWidget(
        MaterialApp(
          theme: MonniTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                captured = context;
                return child;
              },
            ),
          ),
        ),
      );
      return captured;
    }

    TextStyle renderedStyle(WidgetTester tester, String text) {
      final paragraph = tester.renderObject<RenderParagraph>(
        find.descendant(of: find.text(text), matching: find.byType(RichText)),
      );
      return paragraph.text.style!;
    }

    testWidgets('the Scaffold paints bg/app', (tester) async {
      await pumpApp(tester, const SizedBox());
      final material = tester.widget<Material>(
        find
            .descendant(
              of: find.byType(Scaffold),
              matching: find.byType(Material),
            )
            .first,
      );
      expect(material.color, MonniPalette.bgApp);
    });

    testWidgets('plain Text inherits Inter Regular from bodyMedium', (
      tester,
    ) async {
      await pumpApp(tester, const Text('Gastos del mes'));
      final style = renderedStyle(tester, 'Gastos del mes');
      expect(style.fontFamily, 'packages/design_system/Inter');
      expect(style.fontWeight, FontWeight.w400);
      expect(style.fontSize, 12);
      expect(style.color, MonniPalette.textPrimary);
    });

    testWidgets('a button label inherits Space Grotesk Bold', (tester) async {
      await pumpApp(
        tester,
        FilledButton(onPressed: () {}, child: const Text('Guardar')),
      );
      final style = renderedStyle(tester, 'Guardar');
      expect(style.fontFamily, 'packages/design_system/SpaceGrotesk');
      expect(style.fontWeight, FontWeight.w700);
      expect(style.fontSize, 14);
    });

    testWidgets('of(context) returns the registered extensions', (
      tester,
    ) async {
      final context = await pumpApp(tester, const SizedBox());
      expect(MonniColors.of(context), MonniColors.light);
      expect(MonniShadowTheme.of(context), MonniShadowTheme.light);
    });
  });
}
