import 'package:design_system/src/atoms/monni_add_button.dart';
import 'package:design_system/src/atoms/monni_icon.dart';
import 'package:design_system/src/foundations/monni_colors.dart';
import 'package:design_system/src/molecules/monni_nav_item.dart';
import 'package:flutter/widgets.dart';

/// A destination of [MonniBottomNav].
@immutable
class MonniBottomNavItem {
  /// Creates a destination with its [label] and [icon].
  const MonniBottomNavItem({required this.label, required this.icon});

  /// Text under the icon. The caller passes it.
  final String label;

  /// Icon of the destination.
  final MonniIconGlyph icon;
}

/// Bottom navigation bar (Figma "Bottom nav", node 2:178): four
/// destinations and the round "+" button in the middle.
///
/// Stateless: the caller owns the selected index and the navigation.
///
/// The "+" button sticks out [addOverlap] px above the bar. The widget
/// includes that strip so the whole button receives taps; the strip is
/// transparent and lets taps through. Use it with `Scaffold(extendBody:
/// true)` so the content shows behind the strip. The bottom safe-area
/// inset is added under the bar.
class MonniBottomNav extends StatelessWidget {
  /// Creates the bar. [items] must have exactly four entries.
  const MonniBottomNav({
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onAddPressed,
    required this.addLabel,
    super.key,
  });

  /// Height of the bar in Figma, without the safe-area inset.
  static const double barHeight = 82;

  /// How far the "+" button rises above the bar.
  static const double addOverlap = 25;

  /// Space that each middle destination leaves for the "+" button. As in
  /// Figma, the four destinations share the remaining width equally.
  static const double centerGap = 15;

  /// The four destinations, left to right.
  final List<MonniBottomNavItem> items;

  /// Index of the current destination in [items].
  final int selectedIndex;

  /// Called with the index of the tapped destination.
  final ValueChanged<int> onItemSelected;

  /// Called when the "+" button is tapped.
  final VoidCallback onAddPressed;

  /// Accessible name of the "+" button, e.g. "Registrar".
  final String addLabel;

  @override
  Widget build(BuildContext context) {
    assert(items.length == 4, 'MonniBottomNav needs exactly 4 items.');
    assert(
      selectedIndex >= 0 && selectedIndex < items.length,
      'selectedIndex out of range.',
    );
    final colors = MonniColors.of(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return SizedBox(
      height: addOverlap + barHeight + bottomInset,
      child: Stack(
        children: [
          Positioned.fill(
            top: addOverlap,
            child: Container(
              decoration: BoxDecoration(
                color: colors.bg.nav,
                border: Border(top: BorderSide(color: colors.bg.controlOff)),
              ),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 9 + bottomInset),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final (index, item) in items.indexed) ...[
                    if (index == 2) const SizedBox(width: 2 * centerGap),
                    Expanded(
                      child: MonniNavItem(
                        label: item.label,
                        glyph: item.icon,
                        selected: index == selectedIndex,
                        onTap: () => onItemSelected(index),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: MonniAddButton(
                onPressed: onAddPressed,
                semanticLabel: addLabel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
