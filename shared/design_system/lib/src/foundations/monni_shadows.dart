import 'package:flutter/painting.dart';

/// The six shadow styles of the Figma file.
///
/// All are outer shadows with x offset 0 and no spread. Figma blur maps
/// directly to [BoxShadow.blurRadius] (both follow the CSS convention).
/// Colors use [Color.fromRGBO] so the opacity stays exact.
abstract final class MonniShadows {
  /// White cards.
  static const List<BoxShadow> card = [
    BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 17,
      color: Color.fromRGBO(0x2B, 0x32, 0x28, 0.035),
    ),
  ];

  /// Green cards.
  static const List<BoxShadow> raised = [
    BoxShadow(
      offset: Offset(0, 13),
      blurRadius: 28,
      color: Color.fromRGBO(0x2E, 0x67, 0x4B, 0.19),
    ),
  ];

  /// Primary button.
  static const List<BoxShadow> button = [
    BoxShadow(
      offset: Offset(0, 10),
      blurRadius: 22,
      color: Color.fromRGBO(0x2E, 0x6B, 0x4D, 0.20),
    ),
  ];

  /// Selected option and active field.
  static const List<BoxShadow> selected = [
    BoxShadow(
      offset: Offset(0, 5),
      blurRadius: 14,
      color: Color.fromRGBO(0x2E, 0x6B, 0x4D, 0.08),
    ),
  ];

  /// Active segment.
  static const List<BoxShadow> segment = [
    BoxShadow(
      offset: Offset(0, 3),
      blurRadius: 12,
      color: Color.fromRGBO(0x2B, 0x30, 0x27, 0.08),
    ),
  ];

  /// Bottom sheet.
  static const List<BoxShadow> sheet = [
    BoxShadow(
      offset: Offset(0, 24),
      blurRadius: 60,
      color: Color.fromRGBO(0x19, 0x1F, 0x17, 0.24),
    ),
  ];
}
