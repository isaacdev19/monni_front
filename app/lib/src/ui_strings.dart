/// Spanish UI strings, all in one place.
///
/// TEMPORARY: move them to ARB files when localization lands in sprint 2.
/// Features hold no text; `app` passes these strings to their screens.
abstract final class UiStrings {
  /// "Inicio" tab and home title.
  static const String home = 'Inicio';

  /// "Movimientos" tab and transactions title.
  static const String transactions = 'Movimientos';

  /// "Presupuesto" tab and budget title.
  static const String budget = 'Presupuesto';

  /// "Fijos" tab label.
  static const String recurring = 'Fijos';

  /// Recurring items screen title, as in Figma.
  static const String recurringTitle = 'Gastos fijos';

  /// Accessible name of the "+" button.
  static const String add = 'Registrar';

  /// Register-transaction screen title.
  static const String newTransaction = 'Registrar movimiento';
}
