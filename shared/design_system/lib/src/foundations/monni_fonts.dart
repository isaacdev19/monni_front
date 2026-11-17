import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Font families bundled in this package.
///
/// The files live in `assets/fonts/` and are declared in this package's
/// `pubspec.yaml`, so they ship with the app and never load from the network.
/// Weights: Space Grotesk 400, 500 and 700; Inter 400, 600 and 700.
abstract final class MonniFonts {
  /// Package that declares the fonts. Pass it as `TextStyle.package`.
  static const String package = 'design_system';

  /// Titles, amounts and brand.
  static const String spaceGrotesk = 'SpaceGrotesk';

  /// Body text and labels.
  static const String inter = 'Inter';

  static bool _licensesRegistered = false;

  /// Adds the OFL licenses of the bundled fonts to [LicenseRegistry].
  ///
  /// Call it once from the app bootstrap. Later calls do nothing.
  static void registerLicenses() {
    if (_licensesRegistered) return;
    _licensesRegistered = true;
    LicenseRegistry.addLicense(() async* {
      yield LicenseEntryWithLineBreaks(
        const ['Inter'],
        await rootBundle.loadString(
          'packages/$package/assets/fonts/inter/OFL.txt',
        ),
      );
      yield LicenseEntryWithLineBreaks(
        const ['Space Grotesk'],
        await rootBundle.loadString(
          'packages/$package/assets/fonts/space_grotesk/OFL.txt',
        ),
      );
    });
  }
}
