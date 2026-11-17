import 'dart:convert';

import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

const _sg = MonniFonts.spaceGrotesk;
const _inter = MonniFonts.inter;

typedef _Spec = (
  TextStyle style,
  String family,
  FontWeight weight,
  double size,
  double height,
  double spacing,
);

/// Section 2 of docs/design-tokens.md, in the same order.
final Map<String, _Spec> _specs = {
  'display/balance': (
    MonniTypography.displayBalance,
    _sg,
    FontWeight.w400,
    34,
    1.1,
    -1.6,
  ),
  'display/amount': (
    MonniTypography.displayAmount,
    _sg,
    FontWeight.w700,
    43,
    1.2,
    -2,
  ),
  'display/currency': (
    MonniTypography.displayCurrency,
    _sg,
    FontWeight.w700,
    25,
    1.2,
    0,
  ),
  'display/budget': (
    MonniTypography.displayBudget,
    _sg,
    FontWeight.w400,
    26,
    1.5,
    -1,
  ),
  'heading/page': (
    MonniTypography.headingPage,
    _sg,
    FontWeight.w500,
    28,
    1.5,
    -1,
  ),
  'heading/sheet': (
    MonniTypography.headingSheet,
    _sg,
    FontWeight.w500,
    21,
    1.5,
    -0.6,
  ),
  'heading/section': (
    MonniTypography.headingSection,
    _sg,
    FontWeight.w500,
    17,
    1.5,
    -0.5,
  ),
  'heading/empty': (
    MonniTypography.headingEmpty,
    _sg,
    FontWeight.w500,
    15,
    1.5,
    0,
  ),
  'title/item': (MonniTypography.titleItem, _sg, FontWeight.w500, 13, 1.5, 0),
  'title/small': (MonniTypography.titleSmall, _sg, FontWeight.w500, 13, 1.5, 0),
  'brand/wordmark': (
    MonniTypography.brandWordmark,
    _sg,
    FontWeight.w700,
    19,
    1.5,
    -0.6,
  ),
  'brand/mark': (
    MonniTypography.brandMark,
    _sg,
    FontWeight.w700,
    17,
    1.5,
    -0.6,
  ),
  'amount/xl': (MonniTypography.amountXl, _sg, FontWeight.w700, 22, 1.5, 0),
  'amount/lg': (MonniTypography.amountLg, _sg, FontWeight.w700, 19, 1.5, 0),
  'amount/donut': (
    MonniTypography.amountDonut,
    _sg,
    FontWeight.w700,
    18,
    1.5,
    0,
  ),
  'amount/md': (MonniTypography.amountMd, _sg, FontWeight.w700, 16, 1.5, 0),
  'amount/sm': (MonniTypography.amountSm, _sg, FontWeight.w700, 14, 1.5, -0.4),
  'button/primary': (
    MonniTypography.buttonPrimary,
    _sg,
    FontWeight.w700,
    14,
    1.5,
    0,
  ),
  'amount/item': (MonniTypography.amountItem, _sg, FontWeight.w700, 13, 1.5, 0),
  'button/sm': (MonniTypography.buttonSm, _sg, FontWeight.w700, 13, 1.5, 0),
  'amount/row': (MonniTypography.amountRow, _sg, FontWeight.w700, 12, 1.5, 0),
  'amount/xs': (MonniTypography.amountXs, _sg, FontWeight.w700, 11, 1.5, 0),
  'amount/bill': (
    MonniTypography.amountBill,
    _sg,
    FontWeight.w700,
    12,
    1.5,
    -0.2,
  ),
  'amount/tiny': (MonniTypography.amountTiny, _sg, FontWeight.w700, 12, 1.5, 0),
  'body/lg': (MonniTypography.bodyLg, _inter, FontWeight.w400, 13, 1.5, 0),
  'body/md': (MonniTypography.bodyMd, _inter, FontWeight.w400, 11, 1.5, 0),
  'body/sm': (MonniTypography.bodySm, _inter, FontWeight.w400, 12, 1.5, 0),
  'caption/md': (
    MonniTypography.captionMd,
    _inter,
    FontWeight.w400,
    12,
    1.5,
    0,
  ),
  'nav/label': (MonniTypography.navLabel, _inter, FontWeight.w400, 11, 1.5, 0),
  'caption/sm': (
    MonniTypography.captionSm,
    _inter,
    FontWeight.w400,
    11,
    1.5,
    0,
  ),
  'label/md': (MonniTypography.labelMd, _inter, FontWeight.w600, 12, 1.5, 0),
  'label/sm': (MonniTypography.labelSm, _inter, FontWeight.w600, 11, 1.5, 0),
  'label/xs': (MonniTypography.labelXs, _inter, FontWeight.w600, 12, 1.5, 0),
  'label/2xs': (MonniTypography.label2xs, _inter, FontWeight.w600, 12, 1.5, 0),
  'label/3xs': (MonniTypography.label3xs, _inter, FontWeight.w600, 11, 1.5, 0),
  'link/md': (MonniTypography.linkMd, _inter, FontWeight.w700, 11, 1.5, 0),
  'label/strong-xs': (
    MonniTypography.labelStrongXs,
    _inter,
    FontWeight.w700,
    12,
    1.5,
    0,
  ),
  'nav/active': (
    MonniTypography.navActive,
    _inter,
    FontWeight.w700,
    11,
    1.5,
    0,
  ),
};

/// Figma alias -> canonical style (identical styles in the document).
final Map<String, (TextStyle alias, TextStyle canonical)> _aliases = {
  'title/small': (MonniTypography.titleSmall, MonniTypography.titleItem),
  'label/xs': (MonniTypography.labelXs, MonniTypography.labelMd),
  'label/2xs': (MonniTypography.label2xs, MonniTypography.labelMd),
  'label/3xs': (MonniTypography.label3xs, MonniTypography.labelSm),
  'caption/md': (MonniTypography.captionMd, MonniTypography.bodySm),
  'caption/sm': (MonniTypography.captionSm, MonniTypography.bodyMd),
  'nav/label': (MonniTypography.navLabel, MonniTypography.bodyMd),
  'amount/tiny': (MonniTypography.amountTiny, MonniTypography.amountRow),
};

bool _isTabular(TextStyle style) =>
    style.fontFeatures?.contains(const FontFeature.tabularFigures()) ?? false;

/// Renders [style] in a [Text] and returns the style the widget resolved.
Future<TextStyle> _render(WidgetTester tester, TextStyle style) async {
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Text('\$ 1.344.400', style: style),
    ),
  );
  final paragraph = tester.renderObject<RenderParagraph>(find.byType(RichText));
  return paragraph.text.style!;
}

void main() {
  group('values match the document', () {
    test('there are 38 Figma styles', () {
      expect(_specs, hasLength(38));
    });

    for (final MapEntry(
          key: name,
          value: (style, family, weight, size, height, spacing),
        )
        in _specs.entries) {
      test(name, () {
        expect(style.fontFamily, 'packages/${MonniFonts.package}/$family');
        expect(style.fontWeight, weight);
        expect(style.fontSize, size);
        expect(style.height, height);
        expect(style.letterSpacing, spacing);
        expect(style.leadingDistribution, TextLeadingDistribution.even);
        expect(style.color, isNull, reason: 'color comes from MonniColors');
        expect(style.fontSize, greaterThanOrEqualTo(11));
      });
    }
  });

  group('aliases point to the same style', () {
    for (final MapEntry(key: name, value: (alias, canonical))
        in _aliases.entries) {
      test(name, () {
        expect(identical(alias, canonical), isTrue);
      });
    }
  });

  group('tabular figures', () {
    for (final MapEntry(key: name, value: spec) in _specs.entries) {
      final expected =
          name.startsWith('display/') || name.startsWith('amount/');
      test('$name ${expected ? 'uses' : 'does not use'} them', () {
        expect(_isTabular(spec.$1), expected);
      });
    }

    testWidgets('a rendered amount keeps tabular figures', (tester) async {
      final resolved = await _render(tester, MonniTypography.amountXl);
      expect(_isTabular(resolved), isTrue);
    });

    testWidgets('a rendered body text has no tabular figures', (tester) async {
      final resolved = await _render(tester, MonniTypography.bodyLg);
      expect(_isTabular(resolved), isFalse);
    });
  });

  group('rendered text uses the bundled font and weight', () {
    late Map<String, Map<int, String>> manifest;

    setUpAll(() async {
      // FontManifest.json lists every bundled family with its weight files.
      final json = jsonDecode(
        await rootBundle.loadString('FontManifest.json'),
      ) as List<dynamic>;
      manifest = {
        for (final family in json.cast<Map<String, dynamic>>())
          family['family'] as String: {
            for (final font
                in (family['fonts'] as List<dynamic>)
                    .cast<Map<String, dynamic>>())
              (font['weight'] as int?) ?? 400: font['asset'] as String,
          },
      };
    });

    final cases = <String, (TextStyle, String, FontWeight)>{
      'Space Grotesk Regular': (
        MonniTypography.displayBalance,
        _sg,
        FontWeight.w400,
      ),
      'Space Grotesk Medium': (
        MonniTypography.headingPage,
        _sg,
        FontWeight.w500,
      ),
      'Space Grotesk Bold': (MonniTypography.amountXl, _sg, FontWeight.w700),
      'Inter Regular': (MonniTypography.bodyLg, _inter, FontWeight.w400),
      'Inter Semi Bold': (MonniTypography.labelMd, _inter, FontWeight.w600),
      'Inter Bold': (MonniTypography.navActive, _inter, FontWeight.w700),
    };

    for (final MapEntry(key: name, value: (style, family, weight))
        in cases.entries) {
      testWidgets(name, (tester) async {
        final resolved = await _render(tester, style);
        final fullFamily = 'packages/${MonniFonts.package}/$family';
        expect(resolved.fontFamily, fullFamily);
        expect(resolved.fontWeight, weight);

        // In the app the family is prefixed with the package. When this
        // package is the project under test, Flutter registers it bare.
        final asset = (manifest[fullFamily] ?? manifest[family])?[weight.value];
        expect(asset, isNotNull, reason: '$fullFamily $weight not bundled');
        final bytes = await tester.runAsync(() => rootBundle.load(asset!));
        expect(bytes!.lengthInBytes, greaterThan(0));
      });
    }
  });

  group('MonniFonts.registerLicenses', () {
    test('adds the OFL licenses of both fonts', () async {
      MonniFonts.registerLicenses();
      MonniFonts.registerLicenses(); // A second call does not duplicate.

      final texts = <String, List<String>>{};
      await for (final entry in LicenseRegistry.licenses) {
        for (final package in entry.packages) {
          (texts[package] ??= []).add(
            entry.paragraphs.map((p) => p.text).join('\n'),
          );
        }
      }
      for (final font in ['Inter', 'Space Grotesk']) {
        expect(texts[font], hasLength(1), reason: '$font registered once');
        expect(texts[font]!.single, contains('SIL OPEN FONT LICENSE'));
      }
    });
  });
}
