import 'package:flutter/material.dart';

/// Register-transaction screen. Empty for now: it only shows its title.
///
/// Full screen, without the bottom nav; the app bar shows the back button.
class NewTransactionScreen extends StatelessWidget {
  /// Creates the screen. The caller passes the [title] text.
  const NewTransactionScreen({required this.title, super.key});

  /// Screen title.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
