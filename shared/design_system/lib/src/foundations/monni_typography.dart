import 'package:design_system/src/foundations/monni_fonts.dart';
import 'package:flutter/painting.dart';

/// The 38 text styles of the Figma file.
///
/// - `height` is the Figma line height (150 % = 1.5).
/// - `letterSpacing` is in logical pixels, as in Figma.
/// - Leading is split evenly above and below the text, as Figma does.
/// - `display*` and `amount*` styles use tabular figures.
/// - No color: take it from `MonniColors` where the style is used.
///
/// Styles that are identical in Figma are defined once; the other Figma
/// names are aliases of the same constant.
abstract final class MonniTypography {
  // display (tabular figures)

  /// Space Grotesk Regular 34, 110 %, -1.6.
  static const TextStyle displayBalance = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w400,
    fontSize: 34,
    height: 1.1,
    letterSpacing: -1.6,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Space Grotesk Bold 43, 120 %, -2.
  static const TextStyle displayAmount = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 43,
    height: 1.2,
    letterSpacing: -2,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Space Grotesk Bold 25, 120 %.
  static const TextStyle displayCurrency = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 25,
    height: 1.2,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Space Grotesk Regular 26, -1.
  static const TextStyle displayBudget = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w400,
    fontSize: 26,
    height: 1.5,
    letterSpacing: -1,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // heading

  /// Space Grotesk Medium 28, -1.
  static const TextStyle headingPage = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w500,
    fontSize: 28,
    height: 1.5,
    letterSpacing: -1,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Space Grotesk Medium 21, -0.6.
  static const TextStyle headingSheet = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w500,
    fontSize: 21,
    height: 1.5,
    letterSpacing: -0.6,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Space Grotesk Medium 17, -0.5.
  static const TextStyle headingSection = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w500,
    fontSize: 17,
    height: 1.5,
    letterSpacing: -0.5,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Space Grotesk Medium 15.
  static const TextStyle headingEmpty = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w500,
    fontSize: 15,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  // title

  /// Space Grotesk Medium 13.
  static const TextStyle titleItem = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w500,
    fontSize: 13,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Alias of [titleItem] (identical in Figma).
  static const TextStyle titleSmall = titleItem;

  // brand

  /// Space Grotesk Bold 19, -0.6.
  static const TextStyle brandWordmark = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 19,
    height: 1.5,
    letterSpacing: -0.6,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Space Grotesk Bold 17, -0.6.
  static const TextStyle brandMark = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 17,
    height: 1.5,
    letterSpacing: -0.6,
    leadingDistribution: TextLeadingDistribution.even,
  );

  // amount (tabular figures)

  /// Space Grotesk Bold 22.
  static const TextStyle amountXl = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Space Grotesk Bold 19.
  static const TextStyle amountLg = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 19,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Space Grotesk Bold 18.
  static const TextStyle amountDonut = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Space Grotesk Bold 16.
  static const TextStyle amountMd = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Space Grotesk Bold 14, -0.4.
  static const TextStyle amountSm = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.5,
    letterSpacing: -0.4,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Space Grotesk Bold 13.
  static const TextStyle amountItem = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 13,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Space Grotesk Bold 12.
  static const TextStyle amountRow = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Alias of [amountRow] (identical in Figma).
  static const TextStyle amountTiny = amountRow;

  /// Space Grotesk Bold 11.
  static const TextStyle amountXs = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 11,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Space Grotesk Bold 12, -0.2.
  static const TextStyle amountBill = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.5,
    letterSpacing: -0.2,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // button

  /// Space Grotesk Bold 14.
  static const TextStyle buttonPrimary = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Space Grotesk Bold 13.
  static const TextStyle buttonSm = TextStyle(
    fontFamily: MonniFonts.spaceGrotesk,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 13,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  // body, caption and nav (Inter Regular)

  /// Inter Regular 13.
  static const TextStyle bodyLg = TextStyle(
    fontFamily: MonniFonts.inter,
    package: MonniFonts.package,
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Inter Regular 11.
  static const TextStyle bodyMd = TextStyle(
    fontFamily: MonniFonts.inter,
    package: MonniFonts.package,
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Alias of [bodyMd] (identical in Figma).
  static const TextStyle captionSm = bodyMd;

  /// Alias of [bodyMd] (identical in Figma).
  static const TextStyle navLabel = bodyMd;

  /// Inter Regular 12.
  static const TextStyle bodySm = TextStyle(
    fontFamily: MonniFonts.inter,
    package: MonniFonts.package,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Alias of [bodySm] (identical in Figma).
  static const TextStyle captionMd = bodySm;

  // label (Inter Semi Bold)

  /// Inter Semi Bold 12.
  static const TextStyle labelMd = TextStyle(
    fontFamily: MonniFonts.inter,
    package: MonniFonts.package,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Alias of [labelMd] (identical in Figma).
  static const TextStyle labelXs = labelMd;

  /// Alias of [labelMd] (identical in Figma).
  static const TextStyle label2xs = labelMd;

  /// Inter Semi Bold 11.
  static const TextStyle labelSm = TextStyle(
    fontFamily: MonniFonts.inter,
    package: MonniFonts.package,
    fontWeight: FontWeight.w600,
    fontSize: 11,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Alias of [labelSm] (identical in Figma).
  static const TextStyle label3xs = labelSm;

  // Inter Bold

  /// Inter Bold 11.
  static const TextStyle linkMd = TextStyle(
    fontFamily: MonniFonts.inter,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 11,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Inter Bold 12.
  static const TextStyle labelStrongXs = TextStyle(
    fontFamily: MonniFonts.inter,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Inter Bold 11.
  static const TextStyle navActive = TextStyle(
    fontFamily: MonniFonts.inter,
    package: MonniFonts.package,
    fontWeight: FontWeight.w700,
    fontSize: 11,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );
}
