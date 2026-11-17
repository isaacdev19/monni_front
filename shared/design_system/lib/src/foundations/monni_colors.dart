import 'package:design_system/src/foundations/monni_palette.dart';
import 'package:flutter/material.dart';

Color _lerp(Color a, Color b, double t) => Color.lerp(a, b, t)!;

/// Semantic colors of monni, registered as a [ThemeExtension].
///
/// Read them with `MonniColors.of(context)`, for example
/// `MonniColors.of(context).text.primary`.
@immutable
final class MonniColors extends ThemeExtension<MonniColors> {
  /// Creates the semantic colors from their groups.
  const MonniColors({
    required this.text,
    required this.bg,
    required this.border,
    required this.brand,
    required this.status,
    required this.tone,
    required this.chart,
  });

  /// The light theme (Figma mode "Claro").
  static const MonniColors light = MonniColors(
    text: MonniTextColors(
      primary: MonniPalette.textPrimary,
      secondary: MonniPalette.textSecondary,
      tertiary: MonniPalette.textTertiary,
      placeholder: MonniPalette.textPlaceholder,
      sage: MonniPalette.textSage,
      inverse: MonniPalette.textInverse,
      icon: MonniPalette.textIcon,
    ),
    bg: MonniBgColors(
      app: MonniPalette.bgApp,
      surface: MonniPalette.bgSurface,
      nav: MonniPalette.bgNav,
      sunken: MonniPalette.bgSunken,
      fieldIcon: MonniPalette.bgFieldIcon,
      track: MonniPalette.bgTrack,
      controlOff: MonniPalette.bgControlOff,
      badge: MonniPalette.bgBadge,
      scrim: MonniPalette.bgScrim,
    ),
    border: MonniBorderColors(
      divider: MonniPalette.borderDivider,
      card: MonniPalette.borderCard,
      control: MonniPalette.borderControl,
      selected: MonniPalette.borderSelected,
    ),
    brand: MonniBrandColors(
      green: MonniPalette.brandGreen,
      greenCard: MonniPalette.brandGreenCard,
      greenSoft: MonniPalette.brandGreenSoft,
      greenPale: MonniPalette.brandGreenPale,
      coral: MonniPalette.brandCoral,
      coralSoft: MonniPalette.brandCoralSoft,
    ),
    status: MonniStatusColors(
      ok: MonniPalette.statusOk,
      warn: MonniPalette.statusWarn,
      over: MonniPalette.statusOver,
      dangerText: MonniPalette.statusDangerText,
      expense: MonniPalette.statusExpense,
      income: MonniPalette.statusIncome,
    ),
    tone: MonniToneColors(
      lilac: MonniTone(
        fg: MonniPalette.toneLilacFg,
        bg: MonniPalette.toneLilacBg,
      ),
      blue: MonniTone(fg: MonniPalette.toneBlueFg, bg: MonniPalette.toneBlueBg),
      yellow: MonniTone(
        fg: MonniPalette.toneYellowFg,
        bg: MonniPalette.toneYellowBg,
      ),
      green: MonniTone(
        fg: MonniPalette.toneGreenFg,
        bg: MonniPalette.toneGreenBg,
      ),
      mint: MonniTone(fg: MonniPalette.toneMintFg, bg: MonniPalette.toneMintBg),
      coral: MonniTone(
        fg: MonniPalette.toneCoralFg,
        bg: MonniPalette.toneCoralBg,
      ),
    ),
    chart: MonniChartColors(onGreen: MonniPalette.chartOnGreen),
  );

  /// The [MonniColors] of the closest [Theme].
  ///
  /// Throws if the theme does not register the extension.
  static MonniColors of(BuildContext context) {
    final colors = Theme.of(context).extension<MonniColors>();
    assert(colors != null, 'MonniColors is not registered in ThemeData.');
    return colors!;
  }

  /// Text and icon colors.
  final MonniTextColors text;

  /// Background colors.
  final MonniBgColors bg;

  /// Border and divider colors.
  final MonniBorderColors border;

  /// Brand colors.
  final MonniBrandColors brand;

  /// Status colors for budgets and movements.
  final MonniStatusColors status;

  /// Category tones (icon and background pairs).
  final MonniToneColors tone;

  /// Chart colors.
  final MonniChartColors chart;

  @override
  MonniColors copyWith({
    MonniTextColors? text,
    MonniBgColors? bg,
    MonniBorderColors? border,
    MonniBrandColors? brand,
    MonniStatusColors? status,
    MonniToneColors? tone,
    MonniChartColors? chart,
  }) => MonniColors(
    text: text ?? this.text,
    bg: bg ?? this.bg,
    border: border ?? this.border,
    brand: brand ?? this.brand,
    status: status ?? this.status,
    tone: tone ?? this.tone,
    chart: chart ?? this.chart,
  );

  @override
  MonniColors lerp(MonniColors? other, double t) {
    if (other == null) return this;
    return MonniColors(
      text: text.lerp(other.text, t),
      bg: bg.lerp(other.bg, t),
      border: border.lerp(other.border, t),
      brand: brand.lerp(other.brand, t),
      status: status.lerp(other.status, t),
      tone: tone.lerp(other.tone, t),
      chart: chart.lerp(other.chart, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is MonniColors &&
      other.text == text &&
      other.bg == bg &&
      other.border == border &&
      other.brand == brand &&
      other.status == status &&
      other.tone == tone &&
      other.chart == chart;

  @override
  int get hashCode => Object.hash(text, bg, border, brand, status, tone, chart);
}

/// Text and icon colors.
///
/// Figma's `text/strong-muted` is a near duplicate of [secondary] and is
/// intentionally not exposed.
@immutable
final class MonniTextColors {
  /// Creates the text colors.
  const MonniTextColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.placeholder,
    required this.sage,
    required this.inverse,
    required this.icon,
  });

  /// Main text.
  final Color primary;

  /// Secondary text. Also covers Figma's `text/strong-muted`.
  final Color secondary;

  /// Tertiary text. At the 4.5:1 limit on `bg.app`; do not lighten it.
  final Color tertiary;

  /// Hint text in empty fields only. Fails text contrast.
  final Color placeholder;

  /// Muted green-grey text.
  final Color sage;

  /// Text on dark or colored fills.
  final Color inverse;

  /// Icons.
  final Color icon;

  /// Returns a copy with the given colors replaced.
  MonniTextColors copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? placeholder,
    Color? sage,
    Color? inverse,
    Color? icon,
  }) => MonniTextColors(
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    tertiary: tertiary ?? this.tertiary,
    placeholder: placeholder ?? this.placeholder,
    sage: sage ?? this.sage,
    inverse: inverse ?? this.inverse,
    icon: icon ?? this.icon,
  );

  /// Interpolates every color towards [other].
  MonniTextColors lerp(MonniTextColors other, double t) => MonniTextColors(
    primary: _lerp(primary, other.primary, t),
    secondary: _lerp(secondary, other.secondary, t),
    tertiary: _lerp(tertiary, other.tertiary, t),
    placeholder: _lerp(placeholder, other.placeholder, t),
    sage: _lerp(sage, other.sage, t),
    inverse: _lerp(inverse, other.inverse, t),
    icon: _lerp(icon, other.icon, t),
  );

  @override
  bool operator ==(Object other) =>
      other is MonniTextColors &&
      other.primary == primary &&
      other.secondary == secondary &&
      other.tertiary == tertiary &&
      other.placeholder == placeholder &&
      other.sage == sage &&
      other.inverse == inverse &&
      other.icon == icon;

  @override
  int get hashCode => Object.hash(
    primary,
    secondary,
    tertiary,
    placeholder,
    sage,
    inverse,
    icon,
  );
}

/// Background colors.
@immutable
final class MonniBgColors {
  /// Creates the background colors.
  const MonniBgColors({
    required this.app,
    required this.surface,
    required this.nav,
    required this.sunken,
    required this.fieldIcon,
    required this.track,
    required this.controlOff,
    required this.badge,
    required this.scrim,
  });

  /// Screen background.
  final Color app;

  /// Cards and sheets.
  final Color surface;

  /// Bottom navigation.
  final Color nav;

  /// Sunken areas, such as segmented controls.
  final Color sunken;

  /// Background of icons inside fields.
  final Color fieldIcon;

  /// Track of progress bars.
  final Color track;

  /// Switch and controls when off.
  final Color controlOff;

  /// Neutral badges.
  final Color badge;

  /// Overlay behind sheets and dialogs.
  final Color scrim;

  /// Returns a copy with the given colors replaced.
  MonniBgColors copyWith({
    Color? app,
    Color? surface,
    Color? nav,
    Color? sunken,
    Color? fieldIcon,
    Color? track,
    Color? controlOff,
    Color? badge,
    Color? scrim,
  }) => MonniBgColors(
    app: app ?? this.app,
    surface: surface ?? this.surface,
    nav: nav ?? this.nav,
    sunken: sunken ?? this.sunken,
    fieldIcon: fieldIcon ?? this.fieldIcon,
    track: track ?? this.track,
    controlOff: controlOff ?? this.controlOff,
    badge: badge ?? this.badge,
    scrim: scrim ?? this.scrim,
  );

  /// Interpolates every color towards [other].
  MonniBgColors lerp(MonniBgColors other, double t) => MonniBgColors(
    app: _lerp(app, other.app, t),
    surface: _lerp(surface, other.surface, t),
    nav: _lerp(nav, other.nav, t),
    sunken: _lerp(sunken, other.sunken, t),
    fieldIcon: _lerp(fieldIcon, other.fieldIcon, t),
    track: _lerp(track, other.track, t),
    controlOff: _lerp(controlOff, other.controlOff, t),
    badge: _lerp(badge, other.badge, t),
    scrim: _lerp(scrim, other.scrim, t),
  );

  @override
  bool operator ==(Object other) =>
      other is MonniBgColors &&
      other.app == app &&
      other.surface == surface &&
      other.nav == nav &&
      other.sunken == sunken &&
      other.fieldIcon == fieldIcon &&
      other.track == track &&
      other.controlOff == controlOff &&
      other.badge == badge &&
      other.scrim == scrim;

  @override
  int get hashCode => Object.hash(
    app,
    surface,
    nav,
    sunken,
    fieldIcon,
    track,
    controlOff,
    badge,
    scrim,
  );
}

/// Border and divider colors.
@immutable
final class MonniBorderColors {
  /// Creates the border colors.
  const MonniBorderColors({
    required this.divider,
    required this.card,
    required this.control,
    required this.selected,
  });

  /// Divider lines.
  final Color divider;

  /// Card borders.
  final Color card;

  /// Field and control borders.
  final Color control;

  /// Border of the selected option.
  final Color selected;

  /// Returns a copy with the given colors replaced.
  MonniBorderColors copyWith({
    Color? divider,
    Color? card,
    Color? control,
    Color? selected,
  }) => MonniBorderColors(
    divider: divider ?? this.divider,
    card: card ?? this.card,
    control: control ?? this.control,
    selected: selected ?? this.selected,
  );

  /// Interpolates every color towards [other].
  MonniBorderColors lerp(MonniBorderColors other, double t) =>
      MonniBorderColors(
        divider: _lerp(divider, other.divider, t),
        card: _lerp(card, other.card, t),
        control: _lerp(control, other.control, t),
        selected: _lerp(selected, other.selected, t),
      );

  @override
  bool operator ==(Object other) =>
      other is MonniBorderColors &&
      other.divider == divider &&
      other.card == card &&
      other.control == control &&
      other.selected == selected;

  @override
  int get hashCode => Object.hash(divider, card, control, selected);
}

/// Brand colors.
@immutable
final class MonniBrandColors {
  /// Creates the brand colors.
  const MonniBrandColors({
    required this.green,
    required this.greenCard,
    required this.greenSoft,
    required this.greenPale,
    required this.coral,
    required this.coralSoft,
  });

  /// Main brand green. Also valid as text color.
  final Color green;

  /// Green of the large summary cards.
  final Color greenCard;

  /// Soft green fill.
  final Color greenSoft;

  /// Paler green fill.
  final Color greenPale;

  /// Brand coral.
  final Color coral;

  /// Soft coral fill.
  final Color coralSoft;

  /// Returns a copy with the given colors replaced.
  MonniBrandColors copyWith({
    Color? green,
    Color? greenCard,
    Color? greenSoft,
    Color? greenPale,
    Color? coral,
    Color? coralSoft,
  }) => MonniBrandColors(
    green: green ?? this.green,
    greenCard: greenCard ?? this.greenCard,
    greenSoft: greenSoft ?? this.greenSoft,
    greenPale: greenPale ?? this.greenPale,
    coral: coral ?? this.coral,
    coralSoft: coralSoft ?? this.coralSoft,
  );

  /// Interpolates every color towards [other].
  MonniBrandColors lerp(MonniBrandColors other, double t) => MonniBrandColors(
    green: _lerp(green, other.green, t),
    greenCard: _lerp(greenCard, other.greenCard, t),
    greenSoft: _lerp(greenSoft, other.greenSoft, t),
    greenPale: _lerp(greenPale, other.greenPale, t),
    coral: _lerp(coral, other.coral, t),
    coralSoft: _lerp(coralSoft, other.coralSoft, t),
  );

  @override
  bool operator ==(Object other) =>
      other is MonniBrandColors &&
      other.green == green &&
      other.greenCard == greenCard &&
      other.greenSoft == greenSoft &&
      other.greenPale == greenPale &&
      other.coral == coral &&
      other.coralSoft == coralSoft;

  @override
  int get hashCode =>
      Object.hash(green, greenCard, greenSoft, greenPale, coral, coralSoft);
}

/// Status colors for budgets and movements.
@immutable
final class MonniStatusColors {
  /// Creates the status colors.
  const MonniStatusColors({
    required this.ok,
    required this.warn,
    required this.over,
    required this.dangerText,
    required this.expense,
    required this.income,
  });

  /// Budget under 85%. Bars, icons and fills only, never small text.
  final Color ok;

  /// Budget near the limit. Bars, icons and fills only, never small text.
  final Color warn;

  /// Budget exceeded. Bars, icons and fills only, never small text.
  final Color over;

  /// Alert text, such as "Excedido" or "Gasto".
  final Color dangerText;

  /// Fill of the expense chip and similar.
  final Color expense;

  /// Fill of the income chip and similar.
  final Color income;

  /// Returns a copy with the given colors replaced.
  MonniStatusColors copyWith({
    Color? ok,
    Color? warn,
    Color? over,
    Color? dangerText,
    Color? expense,
    Color? income,
  }) => MonniStatusColors(
    ok: ok ?? this.ok,
    warn: warn ?? this.warn,
    over: over ?? this.over,
    dangerText: dangerText ?? this.dangerText,
    expense: expense ?? this.expense,
    income: income ?? this.income,
  );

  /// Interpolates every color towards [other].
  MonniStatusColors lerp(MonniStatusColors other, double t) =>
      MonniStatusColors(
        ok: _lerp(ok, other.ok, t),
        warn: _lerp(warn, other.warn, t),
        over: _lerp(over, other.over, t),
        dangerText: _lerp(dangerText, other.dangerText, t),
        expense: _lerp(expense, other.expense, t),
        income: _lerp(income, other.income, t),
      );

  @override
  bool operator ==(Object other) =>
      other is MonniStatusColors &&
      other.ok == ok &&
      other.warn == warn &&
      other.over == over &&
      other.dangerText == dangerText &&
      other.expense == expense &&
      other.income == income;

  @override
  int get hashCode => Object.hash(ok, warn, over, dangerText, expense, income);
}

/// A category tone: icon color [fg] on background [bg].
///
/// Tones only paint icons (3:1 is enough). As text, blue, yellow and coral
/// do not reach 4.5:1.
@immutable
final class MonniTone {
  /// Creates a tone.
  const MonniTone({required this.fg, required this.bg});

  /// Icon color.
  final Color fg;

  /// Background color.
  final Color bg;

  /// Interpolates both colors towards [other].
  MonniTone lerp(MonniTone other, double t) =>
      MonniTone(fg: _lerp(fg, other.fg, t), bg: _lerp(bg, other.bg, t));

  @override
  bool operator ==(Object other) =>
      other is MonniTone && other.fg == fg && other.bg == bg;

  @override
  int get hashCode => Object.hash(fg, bg);
}

/// Category tones.
@immutable
final class MonniToneColors {
  /// Creates the category tones.
  const MonniToneColors({
    required this.lilac,
    required this.blue,
    required this.yellow,
    required this.green,
    required this.mint,
    required this.coral,
  });

  /// Lilac tone.
  final MonniTone lilac;

  /// Blue tone.
  final MonniTone blue;

  /// Yellow tone.
  final MonniTone yellow;

  /// Green tone.
  final MonniTone green;

  /// Mint tone.
  final MonniTone mint;

  /// Coral tone.
  final MonniTone coral;

  /// Returns a copy with the given tones replaced.
  MonniToneColors copyWith({
    MonniTone? lilac,
    MonniTone? blue,
    MonniTone? yellow,
    MonniTone? green,
    MonniTone? mint,
    MonniTone? coral,
  }) => MonniToneColors(
    lilac: lilac ?? this.lilac,
    blue: blue ?? this.blue,
    yellow: yellow ?? this.yellow,
    green: green ?? this.green,
    mint: mint ?? this.mint,
    coral: coral ?? this.coral,
  );

  /// Interpolates every tone towards [other].
  MonniToneColors lerp(MonniToneColors other, double t) => MonniToneColors(
    lilac: lilac.lerp(other.lilac, t),
    blue: blue.lerp(other.blue, t),
    yellow: yellow.lerp(other.yellow, t),
    green: green.lerp(other.green, t),
    mint: mint.lerp(other.mint, t),
    coral: coral.lerp(other.coral, t),
  );

  @override
  bool operator ==(Object other) =>
      other is MonniToneColors &&
      other.lilac == lilac &&
      other.blue == blue &&
      other.yellow == yellow &&
      other.green == green &&
      other.mint == mint &&
      other.coral == coral;

  @override
  int get hashCode => Object.hash(lilac, blue, yellow, green, mint, coral);
}

/// Chart colors.
@immutable
final class MonniChartColors {
  /// Creates the chart colors.
  const MonniChartColors({required this.onGreen});

  /// Chart strokes on green cards.
  final Color onGreen;

  /// Returns a copy with the given colors replaced.
  MonniChartColors copyWith({Color? onGreen}) =>
      MonniChartColors(onGreen: onGreen ?? this.onGreen);

  /// Interpolates every color towards [other].
  MonniChartColors lerp(MonniChartColors other, double t) =>
      MonniChartColors(onGreen: _lerp(onGreen, other.onGreen, t));

  @override
  bool operator ==(Object other) =>
      other is MonniChartColors && other.onGreen == onGreen;

  @override
  int get hashCode => onGreen.hashCode;
}
