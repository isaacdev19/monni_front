import 'package:app/src/router.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  MonniFonts.registerLicenses();
  runApp(const ProviderScope(child: MonniApp()));
}

/// Root of the monni app. Must sit under a [ProviderScope].
class MonniApp extends ConsumerWidget {
  /// Creates the app.
  const MonniApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'monni',
      theme: MonniTheme.light(),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
