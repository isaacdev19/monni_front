import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [child] centered in a Scaffold with [MonniTheme.light] applied.
Future<void> pumpThemed(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      theme: MonniTheme.light(),
      home: Scaffold(body: Center(child: child)),
    ),
  );
}
