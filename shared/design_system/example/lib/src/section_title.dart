import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Group title inside a catalog page.
class SectionTitle extends StatelessWidget {
  /// Creates a title with [text].
  const SectionTitle(this.text, {super.key});

  /// The title.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(text, style: MonniTypography.headingSection),
    );
  }
}
