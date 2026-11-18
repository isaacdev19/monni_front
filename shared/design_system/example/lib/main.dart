import 'package:design_system/design_system.dart';
import 'package:design_system_example/src/colors_page.dart';
import 'package:design_system_example/src/components_page.dart';
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
        length: 4,
        child: Scaffold(
          // Scaffold grows the app bar slot by the status bar height; the
          // SafeArea keeps the tabs below it.
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight),
            child: SafeArea(
              bottom: false,
              child: TabBar(
                labelPadding: EdgeInsets.symmetric(horizontal: 4),
                labelStyle: MonniTypography.labelMd,
                tabs: [
                  Tab(text: 'Colores'),
                  Tab(text: 'Texto'),
                  Tab(text: 'Sombras'),
                  Tab(text: 'Componentes'),
                ],
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: TabBarView(
              children: [
                ColorsPage(),
                TextStylesPage(),
                ShadowsPage(),
                ComponentsPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
