import 'package:design_system/design_system.dart';
import 'package:design_system_example/src/colors_page.dart';
import 'package:flutter/material.dart';

/// The six shadows on cards over bg/app.
///
/// Cards have square corners on purpose: the radii are not approved yet.
class ShadowsPage extends StatelessWidget {
  /// Creates the page.
  const ShadowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = MonniColors.of(context);
    final s = MonniShadowTheme.of(context);
    final shadows = <String, (List<BoxShadow>, Color)>{
      'shadow/card': (s.card, c.bg.surface),
      'shadow/raised': (s.raised, c.brand.greenCard),
      'shadow/button': (s.button, c.brand.green),
      'shadow/selected': (s.selected, c.bg.surface),
      'shadow/segment': (s.segment, c.bg.surface),
      'shadow/sheet': (s.sheet, c.bg.surface),
    };

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
      children: [
        for (final MapEntry(key: name, value: (shadow, fill))
            in shadows.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Container(
              height: 96,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: fill, boxShadow: shadow),
              child: _Label(
                name: name,
                shadow: shadow.single,
                onDark: fill != c.bg.surface,
              ),
            ),
          ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.name,
    required this.shadow,
    required this.onDark,
  });

  final String name;
  final BoxShadow shadow;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final c = MonniColors.of(context);
    final color = onDark ? c.text.inverse : c.text.primary;
    final opacity = (shadow.color.a * 100).toStringAsFixed(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: MonniTypography.titleItem.copyWith(color: color)),
        Text(
          'y ${shadow.offset.dy.toStringAsFixed(0)} · '
          'blur ${shadow.blurRadius.toStringAsFixed(0)} · '
          '${hex(shadow.color.withValues(alpha: 1))} · $opacity %',
          style: MonniTypography.bodyMd.copyWith(color: color),
        ),
      ],
    );
  }
}
