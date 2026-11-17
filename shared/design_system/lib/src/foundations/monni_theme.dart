import 'package:design_system/src/foundations/monni_colors.dart';
import 'package:design_system/src/foundations/monni_palette.dart';
import 'package:design_system/src/foundations/monni_shadow_theme.dart';
import 'package:design_system/src/foundations/monni_typography.dart';
import 'package:flutter/material.dart';

/// The monni Material 3 theme.
///
/// The [ColorScheme] is written by hand from the Figma tokens (no seed), and
/// the [TextTheme] points to [MonniTypography] styles. Component themes are
/// added only when the app starts using that component.
abstract final class MonniTheme {
  /// Light theme (Figma mode "Claro").
  static ThemeData light() => ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: MonniPalette.bgApp,
    extensions: const [MonniColors.light, MonniShadowTheme.light],
  );

  /// Explicit light color scheme mapped from the tokens.
  ///
  /// `tertiary*` and `*Fixed*` slots have no equivalent in the design and are
  /// left to Flutter's fallbacks (secondary and primary).
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: MonniPalette.brandGreen,
    onPrimary: MonniPalette.textInverse,
    primaryContainer: MonniPalette.brandGreenSoft,
    onPrimaryContainer: MonniPalette.brandGreen,
    secondary: MonniPalette.brandCoral,
    // Dark on coral: white only reaches 3.2:1.
    onSecondary: MonniPalette.textPrimary,
    secondaryContainer: MonniPalette.brandCoralSoft,
    onSecondaryContainer: MonniPalette.statusDangerText,
    error: MonniPalette.statusDangerText,
    onError: MonniPalette.textInverse,
    errorContainer: MonniPalette.brandCoralSoft,
    onErrorContainer: MonniPalette.statusDangerText,
    surface: MonniPalette.bgSurface,
    onSurface: MonniPalette.textPrimary,
    onSurfaceVariant: MonniPalette.textSecondary,
    surfaceBright: MonniPalette.bgSurface,
    surfaceDim: MonniPalette.bgSunken,
    surfaceContainerLowest: MonniPalette.bgSurface,
    surfaceContainerLow: MonniPalette.bgApp,
    surfaceContainer: MonniPalette.bgFieldIcon,
    surfaceContainerHigh: MonniPalette.bgSunken,
    surfaceContainerHighest: MonniPalette.bgTrack,
    // Follows Figma (border/control), below the 3:1 Material 3 suggests.
    outline: MonniPalette.borderControl,
    outlineVariant: MonniPalette.borderDivider,
    shadow: MonniPalette.bgScrim,
    scrim: MonniPalette.bgScrim,
    inverseSurface: MonniPalette.textPrimary,
    onInverseSurface: MonniPalette.bgApp,
    inversePrimary: MonniPalette.chartOnGreen,
    // No Material elevation tint: Figma surfaces are flat colors.
    surfaceTint: Colors.transparent,
  );

  /// Material text roles mapped to Figma styles.
  ///
  /// Styles without a Material role (amount*, brand*, nav*, link*...) are
  /// used directly from [MonniTypography].
  static const TextTheme textTheme = TextTheme(
    displayLarge: MonniTypography.displayAmount,
    displayMedium: MonniTypography.displayBalance,
    displaySmall: MonniTypography.displayBudget,
    headlineLarge: MonniTypography.headingPage,
    headlineMedium: MonniTypography.headingSheet,
    headlineSmall: MonniTypography.headingSection,
    titleLarge: MonniTypography.headingEmpty,
    titleMedium: MonniTypography.titleItem,
    titleSmall: MonniTypography.labelMd,
    bodyLarge: MonniTypography.bodyLg,
    bodyMedium: MonniTypography.bodySm,
    bodySmall: MonniTypography.bodyMd,
    labelLarge: MonniTypography.buttonPrimary,
    labelMedium: MonniTypography.labelMd,
    labelSmall: MonniTypography.labelSm,
  );
}
