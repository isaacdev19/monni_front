import 'package:design_system/design_system.dart';
import 'package:design_system_example/src/section_title.dart';
import 'package:flutter/material.dart';

const _navItems = [
  MonniBottomNavItem(label: 'Inicio', icon: MonniIconGlyph.home),
  MonniBottomNavItem(label: 'Movimientos', icon: MonniIconGlyph.receipt),
  MonniBottomNavItem(label: 'Presupuesto', icon: MonniIconGlyph.chart),
  MonniBottomNavItem(label: 'Fijos', icon: MonniIconGlyph.calendar),
];

/// Every built component in each of its states.
class ComponentsPage extends StatelessWidget {
  /// Creates the page.
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = MonniColors.of(context);
    final caption = MonniTypography.bodySm.copyWith(color: c.text.secondary);
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        const _Padded(SectionTitle('MonniIcon')),
        _Padded(
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              for (final color in [c.brand.green, c.text.tertiary])
                for (final glyph in MonniIconGlyph.values)
                  Column(
                    children: [
                      MonniIcon(glyph, size: 21, color: color),
                      Text(glyph.name, style: caption),
                    ],
                  ),
            ],
          ),
        ),
        const _Padded(SectionTitle('MonniAddButton')),
        _Padded(
          Row(
            children: [
              MonniAddButton(onPressed: () {}, semanticLabel: 'Registrar'),
              const SizedBox(width: 24),
              const MonniAddButton(onPressed: null, semanticLabel: 'Registrar'),
              const SizedBox(width: 12),
              Text('onPressed: null', style: caption),
            ],
          ),
        ),
        const _Padded(SectionTitle('MonniNavItem')),
        _Padded(
          Row(
            children: [
              for (final selected in [true, false])
                SizedBox(
                  width: 92,
                  height: 63,
                  child: MonniNavItem(
                    label: 'Movimientos',
                    glyph: MonniIconGlyph.receipt,
                    selected: selected,
                    onTap: () {},
                  ),
                ),
            ],
          ),
        ),
        const _Padded(SectionTitle('MonniBottomNav')),
        _Padded(
          Text(
            'One per Figma variant. Tap to try it; "+" shows a snackbar.',
            style: caption,
          ),
        ),
        for (final (index, item) in _navItems.indexed) ...[
          _Padded(Text('Activo=${item.label}', style: caption)),
          _NavDemo(initialIndex: index),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _Padded extends StatelessWidget {
  const _Padded(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: child,
  );
}

/// The selected index lives here, in the example: the bar is stateless.
class _NavDemo extends StatefulWidget {
  const _NavDemo({required this.initialIndex});

  final int initialIndex;

  @override
  State<_NavDemo> createState() => _NavDemoState();
}

class _NavDemoState extends State<_NavDemo> {
  late int _selected = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    return MonniBottomNav(
      items: _navItems,
      selectedIndex: _selected,
      onItemSelected: (index) => setState(() => _selected = index),
      onAddPressed: () => ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('onAddPressed'))),
      addLabel: 'Registrar',
    );
  }
}
