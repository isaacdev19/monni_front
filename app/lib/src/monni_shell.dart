import 'dart:async';

import 'package:app/src/router.dart';
import 'package:app/src/ui_strings.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monni_transactions/monni_transactions.dart';

/// Frame of the four tabs: the current tab screen over the bottom nav.
class MonniShell extends StatelessWidget {
  /// Creates the shell for the tab at [location] showing [child].
  const MonniShell({required this.location, required this.child, super.key});

  /// Current path, used to mark the selected tab.
  final String location;

  /// Screen of the current tab.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final index = shellTabs.indexWhere(
      (tab) => location == tab.route || location.startsWith('${tab.route}/'),
    );
    return Scaffold(
      // The "+" rises above the bar; the body shows behind that strip.
      extendBody: true,
      body: child,
      bottomNavigationBar: MonniBottomNav(
        items: [for (final tab in shellTabs) tab.item],
        selectedIndex: index < 0 ? 0 : index,
        onItemSelected: (i) => context.go(shellTabs[i].route),
        onAddPressed: () => unawaited(context.push<void>(newTransactionRoute)),
        addLabel: UiStrings.add,
      ),
    );
  }
}
