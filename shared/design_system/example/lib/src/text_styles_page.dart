import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// A Figma text style; `aliasOf` names the canonical style when identical.
typedef _Entry = (String name, TextStyle style, String? aliasOf);

const List<_Entry> _entries = [
  ('display/balance', MonniTypography.displayBalance, null),
  ('display/amount', MonniTypography.displayAmount, null),
  ('display/currency', MonniTypography.displayCurrency, null),
  ('display/budget', MonniTypography.displayBudget, null),
  ('heading/page', MonniTypography.headingPage, null),
  ('heading/sheet', MonniTypography.headingSheet, null),
  ('heading/section', MonniTypography.headingSection, null),
  ('heading/empty', MonniTypography.headingEmpty, null),
  ('title/item', MonniTypography.titleItem, null),
  ('title/small', MonniTypography.titleSmall, 'title/item'),
  ('brand/wordmark', MonniTypography.brandWordmark, null),
  ('brand/mark', MonniTypography.brandMark, null),
  ('amount/xl', MonniTypography.amountXl, null),
  ('amount/lg', MonniTypography.amountLg, null),
  ('amount/donut', MonniTypography.amountDonut, null),
  ('amount/md', MonniTypography.amountMd, null),
  ('amount/sm', MonniTypography.amountSm, null),
  ('button/primary', MonniTypography.buttonPrimary, null),
  ('amount/item', MonniTypography.amountItem, null),
  ('button/sm', MonniTypography.buttonSm, null),
  ('amount/row', MonniTypography.amountRow, null),
  ('amount/xs', MonniTypography.amountXs, null),
  ('amount/bill', MonniTypography.amountBill, null),
  ('amount/tiny', MonniTypography.amountTiny, 'amount/row'),
  ('body/lg', MonniTypography.bodyLg, null),
  ('body/md', MonniTypography.bodyMd, null),
  ('body/sm', MonniTypography.bodySm, null),
  ('caption/md', MonniTypography.captionMd, 'body/sm'),
  ('nav/label', MonniTypography.navLabel, 'body/md'),
  ('caption/sm', MonniTypography.captionSm, 'body/md'),
  ('label/md', MonniTypography.labelMd, null),
  ('label/sm', MonniTypography.labelSm, null),
  ('label/xs', MonniTypography.labelXs, 'label/md'),
  ('label/2xs', MonniTypography.label2xs, 'label/md'),
  ('label/3xs', MonniTypography.label3xs, 'label/sm'),
  ('link/md', MonniTypography.linkMd, null),
  ('label/strong-xs', MonniTypography.labelStrongXs, null),
  ('nav/active', MonniTypography.navActive, null),
];

/// The 38 Figma text styles with a sample and their values.
class TextStylesPage extends StatelessWidget {
  /// Creates the page.
  const TextStylesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = MonniColors.of(context);
    final specStyle = MonniTypography.bodyMd.copyWith(color: c.text.secondary);
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _entries.length,
      separatorBuilder: (_, _) => Divider(color: c.border.divider),
      itemBuilder: (context, index) {
        final (name, style, aliasOf) = _entries[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              aliasOf == null ? name : '$name  =  $aliasOf',
              style: MonniTypography.labelMd.copyWith(color: c.brand.green),
            ),
            const SizedBox(height: 4),
            Text(
              r'$ 1.344.400 · Gastos del mes',
              style: style.copyWith(color: c.text.primary),
            ),
            Text(_describe(style), style: specStyle),
          ],
        );
      },
    );
  }
}

String _describe(TextStyle style) {
  final family = style.fontFamily!.split('/').last;
  final weight = style.fontWeight!.value;
  final size = style.fontSize!.toStringAsFixed(0);
  final height = (style.height! * 100).round();
  final spacing = style.letterSpacing!;
  final tabular =
      style.fontFeatures?.contains(const FontFeature.tabularFigures()) ?? false;
  return '$family $weight · $size px · $height % · '
      'spacing $spacing${tabular ? ' · tabular' : ''}';
}
