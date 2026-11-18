import 'package:design_system/src/atoms/monni_icon.dart';
import 'package:design_system/src/foundations/monni_colors.dart';
import 'package:design_system/src/foundations/monni_typography.dart';
import 'package:flutter/widgets.dart';

/// One destination of the bottom nav: icon over label.
///
/// Selected: nav/active in brand/green. Not selected: nav/label in
/// text/tertiary. The whole widget is the tap target; the 72 px column
/// is centered inside it.
class MonniNavItem extends StatelessWidget {
  /// Creates a nav item.
  const MonniNavItem({
    required this.label,
    required this.glyph,
    required this.selected,
    required this.onTap,
    super.key,
  });

  /// Width of the icon and label column.
  static const double contentWidth = 72;

  /// Size of the icon.
  static const double iconSize = 21;

  /// Space between icon and label.
  static const double gap = 4;

  /// Text under the icon. The caller passes it.
  final String label;

  /// Icon above the label.
  final MonniIconGlyph glyph;

  /// Whether this is the current destination.
  final bool selected;

  /// Called on tap.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = MonniColors.of(context);
    final color = selected ? colors.brand.green : colors.text.tertiary;
    final style = selected
        ? MonniTypography.navActive
        : MonniTypography.navLabel;
    return Semantics(
      container: true,
      button: true,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: SizedBox(
            width: contentWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MonniIcon(glyph, size: iconSize, color: color),
                const SizedBox(height: gap),
                // No FittedBox: the label must never shrink under 11 px.
                Text(
                  label,
                  style: style.copyWith(color: color),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
