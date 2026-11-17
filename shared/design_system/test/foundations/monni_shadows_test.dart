import 'package:design_system/design_system.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Section 3 of docs/design-tokens.md: (y, blur, rgb, opacity).
  final specs = <String, (List<BoxShadow>, double, double, int, double)>{
    'card': (MonniShadows.card, 6, 17, 0x2B3228, 0.035),
    'raised': (MonniShadows.raised, 13, 28, 0x2E674B, 0.19),
    'button': (MonniShadows.button, 10, 22, 0x2E6B4D, 0.20),
    'selected': (MonniShadows.selected, 5, 14, 0x2E6B4D, 0.08),
    'segment': (MonniShadows.segment, 3, 12, 0x2B3027, 0.08),
    'sheet': (MonniShadows.sheet, 24, 60, 0x191F17, 0.24),
  };

  for (final MapEntry(key: name, value: (shadows, y, blur, rgb, opacity))
      in specs.entries) {
    test('shadow/$name', () {
      expect(shadows, hasLength(1));
      final shadow = shadows.single;
      expect(shadow.offset, Offset(0, y));
      expect(shadow.blurRadius, blur);
      expect(shadow.spreadRadius, 0);
      expect(shadow.blurStyle, BlurStyle.normal);
      expect(shadow.color.toARGB32() & 0xFFFFFF, rgb);
      expect(shadow.color.a, closeTo(opacity, 0.0001));
    });
  }
}
