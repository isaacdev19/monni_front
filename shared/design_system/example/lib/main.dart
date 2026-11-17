import 'package:design_system/design_system.dart';
import 'package:design_system_example/src/colors_page.dart';
import 'package:design_system_example/src/shadows_page.dart';
import 'package:design_system_example/src/text_styles_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CatalogApp());
}

/// Catalog of the monni design tokens, to compare against Figma.
class CatalogApp extends StatelessWidget {
  /// Creates the catalog.
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'monni catalog',
      debugShowCheckedModeBanner: false,
      theme: MonniTheme.light(),
      home: const DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            tabs: [
              Tab(text: 'Colores'),
              Tab(text: 'Texto'),
              Tab(text: 'Sombras'),
            ],
          ),
          body: SafeArea(
            child: TabBarView(
              children: [ColorsPage(), TextStylesPage(), ShadowsPage()],
            ),
          ),
        ),
      ),
    );
  }
}
