import 'package:app/main.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('the app starts with the monni theme', (tester) async {
    await tester.pumpWidget(const MonniApp());

    final context = tester.element(find.byType(Scaffold));
    expect(Theme.of(context).scaffoldBackgroundColor, MonniColors.light.bg.app);
    expect(MonniColors.of(context), MonniColors.light);

    final scaffoldMaterial = tester.widget<Material>(
      find
          .descendant(
            of: find.byType(Scaffold),
            matching: find.byType(Material),
          )
          .first,
    );
    expect(scaffoldMaterial.color, MonniColors.light.bg.app);
  });
}
