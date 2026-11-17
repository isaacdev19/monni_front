import 'dart:ui';

/// The 46 color variables of the Figma file "Monni — Finance App (MVP)",
/// collection "monni", mode "Claro".
///
/// Raw values only. Widgets read colors through `MonniColors`, never from
/// here, so this class is not exported from the package.
abstract final class MonniPalette {
  // text
  static const Color textPrimary = Color(0xFF22251F);
  static const Color textSecondary = Color(0xFF60645C);
  static const Color textTertiary = Color(0xFF6F736C);

  /// Fails text contrast. Only for hint text in empty fields.
  static const Color textPlaceholder = Color(0xFFB4B6AF);

  /// Near duplicate of [textSecondary] in Figma. It is not exposed in
  /// `MonniColors`; use `text.secondary` instead.
  static const Color textStrongMuted = Color(0xFF61655E);
  static const Color textSage = Color(0xFF606E62);
  static const Color textInverse = Color(0xFFFFFFFF);
  static const Color textIcon = Color(0xFF44483F);

  // bg
  static const Color bgApp = Color(0xFFF8F7F2);
  static const Color bgSurface = Color(0xFFFFFFFF);
  static const Color bgNav = Color(0xFFFFFFFD);
  static const Color bgSunken = Color(0xFFEDEEE8);
  static const Color bgFieldIcon = Color(0xFFF0F1EC);
  static const Color bgTrack = Color(0xFFE6E8E2);
  static const Color bgControlOff = Color(0xFFD7D9D3);
  static const Color bgBadge = Color(0xFFDEDFD9);
  static const Color bgScrim = Color(0xFF1B1F19);

  // border
  static const Color borderDivider = Color(0xFFE8E9E2);
  static const Color borderCard = Color(0xFFEBEBE5);
  static const Color borderControl = Color(0xFFE2E3DD);
  static const Color borderSelected = Color(0xFF87A291);

  // brand
  static const Color brandGreen = Color(0xFF2E6B4D);
  static const Color brandGreenCard = Color(0xFF2E674B);
  static const Color brandGreenSoft = Color(0xFFDCEBDD);
  static const Color brandGreenPale = Color(0xFFE2EEE3);
  static const Color brandCoral = Color(0xFFDD725F);
  static const Color brandCoralSoft = Color(0xFFF8DED8);

  // status
  static const Color statusOk = Color(0xFF68A178);
  static const Color statusWarn = Color(0xFFD3AE4F);
  static const Color statusOver = Color(0xFFDC705E);
  static const Color statusDangerText = Color(0xFFAA4334);
  static const Color statusExpense = Color(0xFFC1513E);
  static const Color statusIncome = Color(0xFF527E62);

  // tone (category icon / background)
  static const Color toneLilacFg = Color(0xFF76619B);
  static const Color toneLilacBg = Color(0xFFEEE9F6);
  static const Color toneBlueFg = Color(0xFF4F7390);
  static const Color toneBlueBg = Color(0xFFE3EEF4);
  static const Color toneYellowFg = Color(0xFF94752D);
  static const Color toneYellowBg = Color(0xFFF5ECCD);
  static const Color toneGreenFg = Color(0xFF52755E);
  static const Color toneGreenBg = Color(0xFFE3EEE4);
  static const Color toneMintFg = Color(0xFF377059);
  static const Color toneMintBg = Color(0xFFDCEEE4);
  static const Color toneCoralFg = Color(0xFFB86252);
  static const Color toneCoralBg = Color(0xFFF7E2DC);

  // chart
  static const Color chartOnGreen = Color(0xFFB9D7BD);
}
