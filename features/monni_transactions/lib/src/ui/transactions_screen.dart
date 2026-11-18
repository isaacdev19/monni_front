import 'package:flutter/material.dart';

/// Transactions tab. Empty for now: it only shows its title.
class TransactionsScreen extends StatelessWidget {
  /// Creates the screen. The caller passes the [title] text.
  const TransactionsScreen({required this.title, super.key});

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
