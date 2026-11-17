import 'package:design_system/src/foundations/monni_shadows.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The six monni shadows, registered as a [ThemeExtension].
///
/// Read them with `MonniShadowTheme.of(context)`, for example
/// `BoxDecoration(boxShadow: MonniShadowTheme.of(context).card)`.
@immutable
final class MonniShadowTheme extends ThemeExtension<MonniShadowTheme> {
  /// Creates the shadow set.
  const MonniShadowTheme({
    required this.card,
    required this.raised,
    required this.button,
    required this.selected,
    required this.segment,
    required this.sheet,
  });

  /// The light theme (Figma mode "Claro").
  static const MonniShadowTheme light = MonniShadowTheme(
    card: MonniShadows.card,
    raised: MonniShadows.raised,
    button: MonniShadows.button,
    selected: MonniShadows.selected,
    segment: MonniShadows.segment,
    sheet: MonniShadows.sheet,
  );

  /// The [MonniShadowTheme] of the closest [Theme].
  ///
  /// Throws if the theme does not register the extension.
  static MonniShadowTheme of(BuildContext context) {
    final shadows = Theme.of(context).extension<MonniShadowTheme>();
    assert(shadows != null, 'MonniShadowTheme is not registered in ThemeData.');
    return shadows!;
  }

  /// White cards.
  final List<BoxShadow> card;

  /// Green cards.
  final List<BoxShadow> raised;

  /// Primary button.
  final List<BoxShadow> button;

  /// Selected option and active field.
  final List<BoxShadow> selected;

  /// Active segment.
  final List<BoxShadow> segment;

  /// Bottom sheet.
  final List<BoxShadow> sheet;

  @override
  MonniShadowTheme copyWith({
    List<BoxShadow>? card,
    List<BoxShadow>? raised,
    List<BoxShadow>? button,
    List<BoxShadow>? selected,
    List<BoxShadow>? segment,
    List<BoxShadow>? sheet,
  }) => MonniShadowTheme(
    card: card ?? this.card,
    raised: raised ?? this.raised,
    button: button ?? this.button,
    selected: selected ?? this.selected,
    segment: segment ?? this.segment,
    sheet: sheet ?? this.sheet,
  );

  @override
  MonniShadowTheme lerp(MonniShadowTheme? other, double t) {
    if (other == null) return this;
    List<BoxShadow> mix(List<BoxShadow> a, List<BoxShadow> b) =>
        BoxShadow.lerpList(a, b, t)!;
    return MonniShadowTheme(
      card: mix(card, other.card),
      raised: mix(raised, other.raised),
      button: mix(button, other.button),
      selected: mix(selected, other.selected),
      segment: mix(segment, other.segment),
      sheet: mix(sheet, other.sheet),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is MonniShadowTheme &&
      listEquals(other.card, card) &&
      listEquals(other.raised, raised) &&
      listEquals(other.button, button) &&
      listEquals(other.selected, selected) &&
      listEquals(other.segment, segment) &&
      listEquals(other.sheet, sheet);

  @override
  int get hashCode => Object.hash(
    Object.hashAll(card),
    Object.hashAll(raised),
    Object.hashAll(button),
    Object.hashAll(selected),
    Object.hashAll(segment),
    Object.hashAll(sheet),
  );
}
