import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/pump.dart';

void main() {
  const colors = MonniColors.light;

  Future<void> pumpItem(
    WidgetTester tester, {
    required bool selected,
    VoidCallback? onTap,
  }) {
    return pumpThemed(
      tester,
      SizedBox(
        width: 92,
        height: 63,
        child: MonniNavItem(
          label: 'Movimientos',
          glyph: MonniIconGlyph.receipt,
          selected: selected,
          onTap: onTap ?? () {},
        ),
      ),
    );
  }

  testWidgets('selected uses nav/active in brand/green', (tester) async {
    await pumpItem(tester, selected: true);

    final text = tester.widget<Text>(find.text('Movimientos'));
    expect(text.style!.fontWeight, FontWeight.w700);
    expect(text.style!.fontSize, 11);
    expect(text.style!.color, colors.brand.green);
    expect(
      tester.widget<MonniIcon>(find.byType(MonniIcon)).color,
      colors.brand.green,
    );
  });

  testWidgets('not selected uses nav/label in text/tertiary', (tester) async {
    await pumpItem(tester, selected: false);

    final text = tester.widget<Text>(find.text('Movimientos'));
    expect(text.style!.fontWeight, FontWeight.w400);
    expect(text.style!.fontSize, 11);
    expect(text.style!.color, colors.text.tertiary);
    expect(
      tester.widget<MonniIcon>(find.byType(MonniIcon)).color,
      colors.text.tertiary,
    );
  });

  testWidgets('the whole item is the tap target', (tester) async {
    var taps = 0;
    await pumpItem(tester, selected: false, onTap: () => taps++);

    // A corner of the 92 px slot, outside the 72 px icon and label column.
    final topLeft = tester.getTopLeft(find.byType(MonniNavItem));
    await tester.tapAt(topLeft + const Offset(2, 2));
    expect(taps, 1);
  });
}
