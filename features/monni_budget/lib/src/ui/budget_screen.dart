import 'package:flutter/material.dart';

/// Budget tab. Empty for now: it only shows its title.
class BudgetScreen extends StatelessWidget {
  /// Creates the screen. The caller passes the [title] text.
  const BudgetScreen({required this.title, super.key});

  /// Screen title.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title, style: Theme.of(context).textTheme.headlineLarge),
        ),
      ),
    );
  }
}
