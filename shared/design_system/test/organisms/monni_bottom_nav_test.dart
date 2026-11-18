import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const _items = [
  MonniBottomNavItem(label: 'Inicio', icon: MonniIconGlyph.home),
  MonniBottomNavItem(label: 'Movimientos', icon: MonniIconGlyph.receipt),
  MonniBottomNavItem(label: 'Presupuesto', icon: MonniIconGlyph.chart),
  MonniBottomNavItem(label: 'Fijos', icon: MonniIconGlyph.calendar),
];

void main() {
  const colors = MonniColors.light;

  Future<void> pumpNav(
    WidgetTester tester, {
    int selectedIndex = 0,
    List<MonniBottomNavItem> items = _items,
    ValueChanged<int>? onItemSelected,
    VoidCallback? onAddPressed,
    VoidCallback? onBodyTap,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return tester.pumpWidget(
      MaterialApp(
        theme: MonniTheme.light(),
        home: MediaQuery(
          data: MediaQueryData(size: const Size(390, 844), padding: padding),
          child: Scaffold(
            extendBody: true,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onBodyTap,
              child: const SizedBox.expand(),
            ),
            bottomNavigationBar: MonniBottomNav(
              items: items,
              selectedIndex: selectedIndex,
              onItemSelected: onItemSelected ?? (_) {},
              onAddPressed: onAddPressed ?? () {},
              addLabel: 'Registrar',
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('marks only the selected destination', (tester) async {
    final semantics = tester.ensureSemantics();
    await pumpNav(tester, selectedIndex: 2);

    for (final (index, item) in _items.indexed) {
      final selected = index == 2;
      final text = tester.widget<Text>(find.text(item.label));
      expect(
        text.style!.fontWeight,
        selected ? FontWeight.w700 : FontWeight.w400,
      );
      expect(
        text.style!.color,
        selected ? colors.brand.green : colors.text.tertiary,
      );
      expect(
        tester.getSemantics(find.text(item.label)),
        isSemantics(label: item.label, isButton: true, isSelected: selected),
      );
    }
    semantics.dispose();
  });

  testWidgets('calls onItemSelected with the tapped index', (tester) async {
    final tapped = <int>[];
    await pumpNav(tester, onItemSelected: tapped.add);

    for (final item in _items) {
      await tester.tap(find.text(item.label));
    }
    expect(tapped, [0, 1, 2, 3]);
  });

  testWidgets('calls onAddPressed, also on the part above the bar', (
    tester,
  ) async {
    var adds = 0;
    var bodyTaps = 0;
    await pumpNav(
      tester,
      onAddPressed: () => adds++,
      onBodyTap: () => bodyTaps++,
    );

    await tester.tap(find.byType(MonniAddButton));
    expect(adds, 1);

    // 8 px below the button's top: inside the circle, above the bar.
    final buttonTop = tester.getTopLeft(find.byType(MonniAddButton));
    final barTop =
        tester.getTopLeft(find.byType(MonniBottomNav)).dy +
        MonniBottomNav.addOverlap;
    final point = buttonTop + const Offset(MonniAddButton.size / 2, 8);
    expect(point.dy, lessThan(barTop));
    await tester.tapAt(point);
    expect(adds, 2);
    expect(bodyTaps, 0);
  });

  testWidgets('the strip beside the button lets taps through', (tester) async {
    var adds = 0;
    var bodyTaps = 0;
    await pumpNav(
      tester,
      onAddPressed: () => adds++,
      onBodyTap: () => bodyTaps++,
    );

    final navTop = tester.getTopLeft(find.byType(MonniBottomNav)).dy;
    await tester.tapAt(Offset(20, navTop + 10));
    expect(bodyTaps, 1);
    expect(adds, 0);
  });

  testWidgets('no text is smaller than 11 px', (tester) async {
    await pumpNav(tester);

    final paragraphs = tester.renderObjectList<RenderParagraph>(
      find.descendant(
        of: find.byType(MonniBottomNav),
        matching: find.byType(RichText),
      ),
    );
    expect(paragraphs, hasLength(_items.length));
    for (final paragraph in paragraphs) {
      final size = paragraph.text.style!.fontSize!;
      expect(paragraph.textScaler.scale(size), greaterThanOrEqualTo(11));
    }
  });

  testWidgets('places the destinations where Figma does at 390 px', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await pumpNav(tester);

    // Figma: 10 px side padding, 30 px gap in the middle, four equal
    // 85 px slots.
    final centers = [
      for (final item in _items)
        tester
            .getCenter(
              find.byWidgetPredicate(
                (w) => w is MonniNavItem && w.label == item.label,
              ),
            )
            .dx,
    ];
    expect(centers, [52.5, 137.5, 252.5, 337.5]);
  });

  testWidgets('is 82 px tall plus the overlap and the bottom inset', (
    tester,
  ) async {
    await pumpNav(tester, padding: const EdgeInsets.only(bottom: 34));

    expect(tester.getSize(find.byType(MonniBottomNav)).height, 25 + 82 + 34);
  });

  testWidgets('asserts that there are exactly four items', (tester) async {
    await pumpNav(tester, items: _items.sublist(0, 3));

    expect(tester.takeException(), isAssertionError);
  });
}
