// Manual playground for Money and MoneyFormat.
//
// Run from shared/core:
//   dart run example/money_example.dart
//
// It prints reference amounts, then reads amounts from stdin and shows how
// they are parsed and formatted. Press Enter on an empty line twice, or
// Ctrl+D, to exit. Anything worth keeping should become a unit test.
import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';

const MoneyFormat _format = MoneyFormat();

void main() {
  stdout
    ..writeln('Reference amounts')
    ..writeln('-----------------');
  for (final money in [
    Money.zero,
    const Money(5),
    const Money(1000),
    const Money(1344400),
    const Money(Money.maxPesos),
    const Money(-50000),
  ]) {
    stdout.writeln(
      '${money.pesos.toString().padLeft(16)}  ->  '
      '${_visible(_format.format(money))}',
    );
  }

  stdout
    ..writeln()
    ..writeln('Type an amount as a user would (empty line twice to exit).');

  var emptyLines = 0;
  while (true) {
    stdout.write('> ');
    final line = stdin.readLineSync(encoding: utf8);
    if (line == null) {
      break;
    }
    emptyLines = line.isEmpty ? emptyLines + 1 : 0;
    if (emptyLines == 2) {
      break;
    }
    stdout.writeln('  ${_describe(_format.parse(line))}');
  }
}

String _describe(MoneyParseResult result) => switch (result) {
  MoneyParsed(:final money) =>
    'parsed: ${money.pesos} pesos  ->  ${_visible(_format.format(money))}',
  MoneyEmpty() => 'empty',
  MoneyInvalid(:final error) => 'invalid: ${error.name}',
};

/// Shows the non-breaking space as a middle dot so it can be seen.
String _visible(String text) => text.replaceAll('\u00A0', '·');
