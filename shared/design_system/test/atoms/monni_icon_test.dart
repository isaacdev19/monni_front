import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/pump.dart';

void main() {
  for (final glyph in MonniIconGlyph.values) {
    group('MonniIcon ${glyph.name}', () {
      test('ships its SVG asset', () async {
        final svg = await rootBundle.loadString(
          'packages/design_system/${glyph.assetPath}',
        );
        expect(svg, contains('<svg'));
      });

      testWidgets('draws the asset with the requested size and tint', (
        tester,
      ) async {
        const tint = Color(0xFF2E6B4D);
        await pumpThemed(tester, MonniIcon(glyph, size: 21, color: tint));

        final picture = tester.widget<SvgPicture>(find.byType(SvgPicture));
        final loader = picture.bytesLoader as SvgAssetLoader;
        expect(loader.assetName, glyph.assetPath);
        expect(loader.packageName, 'design_system');
        expect(picture.width, 21);
        expect(picture.height, 21);
        expect(
          picture.colorFilter,
          const ColorFilter.mode(tint, BlendMode.srcIn),
        );
        expect(picture.excludeFromSemantics, isTrue);
      });
    });
  }

  testWidgets('MonniIcon falls back to the IconTheme color', (tester) async {
    const tint = Color(0xFF6F736C);
    await pumpThemed(
      tester,
      const IconTheme(
        data: IconThemeData(color: tint),
        child: MonniIcon(MonniIconGlyph.home, size: 21),
      ),
    );

    final picture = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(picture.colorFilter, const ColorFilter.mode(tint, BlendMode.srcIn));
  });
}
