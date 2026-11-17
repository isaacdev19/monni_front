import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

void main() {
  MonniFonts.registerLicenses();
  runApp(const MonniApp());
}

/// Root of the monni app.
class MonniApp extends StatelessWidget {
  /// Creates the app.
  const MonniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'monni',
      theme: MonniTheme.light(),
      // Placeholder until the home screen and routes exist.
      home: const Scaffold(body: Center(child: Text('monni'))),
    );
  }
}
