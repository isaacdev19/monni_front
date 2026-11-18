import 'package:flutter/material.dart';

/// Recurring items tab ("Fijos"). Empty for now: it only shows its title.
class RecurringScreen extends StatelessWidget {
  /// Creates the screen. The caller passes the [title] text.
  const RecurringScreen({required this.title, super.key});

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
