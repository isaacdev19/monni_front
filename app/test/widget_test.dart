import 'package:app/main.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('the app starts with the monni theme', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MonniApp()));
    await tester.pumpAndSettle();

    final scaffold = find.byType(Scaffold).first;
    final context = tester.element(scaffold);
    expect(Theme.of(context).scaffoldBackgroundColor, MonniColors.light.bg.app);
    expect(MonniColors.of(context), MonniColors.light);

    final scaffoldMaterial = tester.widget<Material>(
      find.descendant(of: scaffold, matching: find.byType(Material)).first,
    );
    expect(scaffoldMaterial.color, MonniColors.light.bg.app);
  });
}
