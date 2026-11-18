import 'package:design_system/src/atoms/monni_icon.dart';
import 'package:design_system/src/foundations/monni_colors.dart';
import 'package:design_system/src/foundations/monni_shadow_theme.dart';
import 'package:flutter/material.dart';

/// Round green "+" button that opens the register flow (Figma
/// "FAB · Registrar").
///
/// A 58 px circle in brand/green with a 5 px bg/app ring and the button
/// shadow.
class MonniAddButton extends StatelessWidget {
  /// Creates the button. [semanticLabel] is read by screen readers.
  const MonniAddButton({
    required this.onPressed,
    required this.semanticLabel,
    super.key,
  });

  /// Diameter, ring included.
  static const double size = 58;

  /// Width of the bg/app ring.
  static const double ringWidth = 5;

  /// Size of the plus icon.
  static const double iconSize = 28;

  /// Called on tap. `null` disables the button.
  final VoidCallback? onPressed;

  /// Accessible name, e.g. "Registrar". The caller passes the text.
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = MonniColors.of(context);
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: semanticLabel,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: MonniShadowTheme.of(context).button,
        ),
        child: Material(
          color: colors.brand.green,
          shape: CircleBorder(
            side: BorderSide(color: colors.bg.app, width: ringWidth),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox.square(
              dimension: size,
              child: Center(
                child: MonniIcon(
                  MonniIconGlyph.plus,
                  size: iconSize,
                  color: colors.text.inverse,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
