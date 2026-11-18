import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Icons exported from Figma (`icon/*`) and bundled as SVG assets.
///
/// Only the icons a built component needs are here; add the rest of the
/// Figma set when a sprint needs them.
enum MonniIconGlyph {
  /// `icon/home`.
  home,

  /// `icon/receipt`.
  receipt,

  /// `icon/chart`.
  chart,

  /// `icon/calendar`.
  calendar,

  /// `icon/plus`.
  plus;

  /// Asset path inside the `design_system` package.
  String get assetPath => 'assets/icons/$name.svg';
}

/// A monni icon, tinted with [color].
///
/// Decorative: it adds nothing to the semantics tree. The widget that holds
/// it gives the label.
class MonniIcon extends StatelessWidget {
  /// Creates an icon of [glyph] that is [size] pixels square.
  const MonniIcon(this.glyph, {required this.size, this.color, super.key});

  /// Package that bundles the SVG files.
  static const String package = 'design_system';

  /// Which icon to draw.
  final MonniIconGlyph glyph;

  /// Width and height in logical pixels.
  final double size;

  /// Tint. Defaults to the ambient [IconTheme] color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tint =
        color ?? IconTheme.of(context).color ?? const Color(0xFF000000);
    return SvgPicture.asset(
      glyph.assetPath,
      package: package,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(tint, BlendMode.srcIn),
      excludeFromSemantics: true,
    );
  }
}
