import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/pump.dart';

void main() {
  testWidgets('is a 58 px circle with the ring, shadow and plus icon', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      MonniAddButton(onPressed: () {}, semanticLabel: 'Registrar'),
    );

    expect(tester.getSize(find.byType(MonniAddButton)), const Size(58, 58));

    final decorated = tester.widget<DecoratedBox>(
      find.descendant(
        of: find.byType(MonniAddButton),
        matching: find.byType(DecoratedBox),
      ),
    );
    final decoration = decorated.decoration as BoxDecoration;
    expect(decoration.shape, BoxShape.circle);
    expect(decoration.boxShadow, MonniShadowTheme.light.button);

    final material = tester.widget<Material>(
      find.descendant(
        of: find.byType(MonniAddButton),
        matching: find.byType(Material),
      ),
    );
    expect(material.color, MonniColors.light.brand.green);
    expect(
      material.shape,
      CircleBorder(side: BorderSide(color: MonniColors.light.bg.app, width: 5)),
    );

    final icon = tester.widget<MonniIcon>(find.byType(MonniIcon));
    expect(icon.glyph, MonniIconGlyph.plus);
    expect(icon.size, 28);
    expect(icon.color, MonniColors.light.text.inverse);
  });

  testWidgets('exposes its label and calls onPressed', (tester) async {
    final semantics = tester.ensureSemantics();
    var taps = 0;
    await pumpThemed(
      tester,
      MonniAddButton(onPressed: () => taps++, semanticLabel: 'Registrar'),
    );

    expect(
      tester.getSemantics(find.byType(MonniAddButton)),
      isSemantics(label: 'Registrar', isButton: true, isEnabled: true),
    );

    await tester.tap(find.byType(MonniAddButton));
    expect(taps, 1);
    semantics.dispose();
  });
}
