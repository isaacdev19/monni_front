import 'package:design_system/design_system.dart';
import 'package:design_system_example/src/section_title.dart';
import 'package:flutter/material.dart';

/// Hex string of an opaque color, e.g. `#2e6b4d`.
String hex(Color color) =>
    '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

/// Every color role of [MonniColors], grouped as in Figma.
class ColorsPage extends StatelessWidget {
  /// Creates the page.
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = MonniColors.of(context);
    final groups = <String, List<(String, Color)>>{
      'text': [
        ('text/primary', c.text.primary),
        ('text/secondary (also text/strong-muted)', c.text.secondary),
        ('text/tertiary', c.text.tertiary),
        ('text/placeholder', c.text.placeholder),
        ('text/sage', c.text.sage),
        ('text/inverse', c.text.inverse),
        ('text/icon', c.text.icon),
      ],
      'bg': [
        ('bg/app', c.bg.app),
        ('bg/surface', c.bg.surface),
        ('bg/nav', c.bg.nav),
        ('bg/sunken', c.bg.sunken),
        ('bg/field-icon', c.bg.fieldIcon),
        ('bg/track', c.bg.track),
        ('bg/control-off', c.bg.controlOff),
        ('bg/badge', c.bg.badge),
        ('bg/scrim', c.bg.scrim),
      ],
      'border': [
        ('border/divider', c.border.divider),
        ('border/card', c.border.card),
        ('border/control', c.border.control),
        ('border/selected', c.border.selected),
      ],
      'brand': [
        ('brand/green', c.brand.green),
        ('brand/green-card', c.brand.greenCard),
        ('brand/green-soft', c.brand.greenSoft),
        ('brand/green-pale', c.brand.greenPale),
        ('brand/coral', c.brand.coral),
        ('brand/coral-soft', c.brand.coralSoft),
      ],
      'status': [
        ('status/ok', c.status.ok),
        ('status/warn', c.status.warn),
        ('status/over', c.status.over),
        ('status/danger-text', c.status.dangerText),
        ('status/expense', c.status.expense),
        ('status/income', c.status.income),
      ],
      'tone': [
        for (final (name, tone) in [
          ('lilac', c.tone.lilac),
          ('blue', c.tone.blue),
          ('yellow', c.tone.yellow),
          ('green', c.tone.green),
          ('mint', c.tone.mint),
          ('coral', c.tone.coral),
        ]) ...[('tone/$name-fg', tone.fg), ('tone/$name-bg', tone.bg)],
      ],
      'chart': [('chart/on-green', c.chart.onGreen)],
    };

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '45 roles. text/strong-muted (#61655e) is merged into '
          'text/secondary.',
          style: MonniTypography.bodySm.copyWith(color: c.text.secondary),
        ),
        for (final MapEntry(key: group, value: colors) in groups.entries) ...[
          SectionTitle(group),
          for (final (name, color) in colors) _Swatch(name: name, color: color),
        ],
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final c = MonniColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: c.border.card),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: MonniTypography.bodyLg)),
          Text(
            hex(color),
            style: MonniTypography.amountRow.copyWith(color: c.text.secondary),
          ),
        ],
      ),
    );
  }
}
