import 'package:app/main.dart';
import 'package:app/src/ui_strings.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:monni_budget/monni_budget.dart';
import 'package:monni_home/monni_home.dart';
import 'package:monni_recurring/monni_recurring.dart';
import 'package:monni_transactions/monni_transactions.dart';

/// Tab label, screen type, screen title and route, left to right.
const _tabs = [
  (UiStrings.home, HomeScreen, UiStrings.home, homeRoute),
  (
    UiStrings.transactions,
    TransactionsScreen,
    UiStrings.transactions,
    transactionsRoute,
  ),
  (UiStrings.budget, BudgetScreen, UiStrings.budget, budgetRoute),
  (
    UiStrings.recurring,
    RecurringScreen,
    UiStrings.recurringTitle,
    recurringRoute,
  ),
];

Future<void> _pumpApp(WidgetTester tester) async {
  await tester.pumpWidget(const ProviderScope(child: MonniApp()));
  await tester.pumpAndSettle();
}

/// Path of the top route, including routes opened with `push`.
String _location(WidgetTester tester) {
  final context = tester.element(find.byType(Navigator).first);
  return GoRouter.of(context).state.uri.path;
}

int _selectedIndex(WidgetTester tester) =>
    tester.widget<MonniBottomNav>(find.byType(MonniBottomNav)).selectedIndex;

/// Finds the tab label inside the bottom nav, not the screen title.
Finder _tabLabel(String label) => find.descendant(
  of: find.byType(MonniBottomNav),
  matching: find.text(label),
);

void main() {
  testWidgets('starts on the home tab', (tester) async {
    await _pumpApp(tester);

    expect(_location(tester), homeRoute);
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(_selectedIndex(tester), 0);
  });

  testWidgets('each tab shows its screen', (tester) async {
    await _pumpApp(tester);

    // Visit every tab, then come back to the first one.
    for (final (index, (label, screen, title, route)) in [
      ..._tabs.skip(1),
      _tabs.first,
    ].indexed) {
      await tester.tap(_tabLabel(label));
      await tester.pumpAndSettle();

      expect(_location(tester), route, reason: 'tab $label');
      expect(find.byType(screen), findsOneWidget, reason: 'tab $label');
      expect(
        find.descendant(of: find.byType(screen), matching: find.text(title)),
        findsOneWidget,
        reason: 'tab $label',
      );
      expect(_selectedIndex(tester), (index + 1) % _tabs.length);
      for (final (_, other, _, _) in _tabs) {
        if (other != screen) expect(find.byType(other), findsNothing);
      }
    }
  });

  testWidgets('"+" opens /transactions/new and back returns', (tester) async {
    await _pumpApp(tester);
    await tester.tap(_tabLabel(UiStrings.budget));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MonniAddButton));
    await tester.pumpAndSettle();

    expect(_location(tester), newTransactionRoute);
    expect(find.byType(NewTransactionScreen), findsOneWidget);
    expect(find.text(UiStrings.newTransaction), findsOneWidget);
    expect(find.byType(MonniBottomNav), findsNothing);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(_location(tester), budgetRoute);
    expect(find.byType(BudgetScreen), findsOneWidget);
    expect(_selectedIndex(tester), 2);
  });
}
