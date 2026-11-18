import 'package:app/src/monni_shell.dart';
import 'package:app/src/ui_strings.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monni_budget/monni_budget.dart';
import 'package:monni_home/monni_home.dart';
import 'package:monni_recurring/monni_recurring.dart';
import 'package:monni_transactions/monni_transactions.dart';

/// A bottom nav tab: its route and how it looks in the bar.
typedef ShellTab = ({String route, MonniBottomNavItem item});

/// The four tabs, left to right.
const List<ShellTab> shellTabs = [
  (
    route: homeRoute,
    item: MonniBottomNavItem(label: UiStrings.home, icon: MonniIconGlyph.home),
  ),
  (
    route: transactionsRoute,
    item: MonniBottomNavItem(
      label: UiStrings.transactions,
      icon: MonniIconGlyph.receipt,
    ),
  ),
  (
    route: budgetRoute,
    item: MonniBottomNavItem(
      label: UiStrings.budget,
      icon: MonniIconGlyph.chart,
    ),
  ),
  (
    route: recurringRoute,
    item: MonniBottomNavItem(
      label: UiStrings.recurring,
      icon: MonniIconGlyph.calendar,
    ),
  ),
];

/// The app router. Navigation lives only in `app`.
///
/// ```
/// ShellRoute (MonniShell + MonniBottomNav)
/// ├── /home
/// ├── /transactions
/// ├── /budget
/// └── /recurring
/// /transactions/new   full screen, without the bottom nav
/// ```
final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: homeRoute,
    routes: [
      ShellRoute(
        builder: (context, state, child) =>
            MonniShell(location: state.uri.path, child: child),
        routes: [
          GoRoute(
            path: homeRoute,
            builder: (context, state) =>
                const HomeScreen(title: UiStrings.home),
          ),
          GoRoute(
            path: transactionsRoute,
            builder: (context, state) =>
                const TransactionsScreen(title: UiStrings.transactions),
          ),
          GoRoute(
            path: budgetRoute,
            builder: (context, state) =>
                const BudgetScreen(title: UiStrings.budget),
          ),
          GoRoute(
            path: recurringRoute,
            builder: (context, state) =>
                const RecurringScreen(title: UiStrings.recurringTitle),
          ),
        ],
      ),
      GoRoute(
        path: newTransactionRoute,
        builder: (context, state) =>
            const NewTransactionScreen(title: UiStrings.newTransaction),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
