import 'package:diet_tracker/pages/reports.dart';
import 'package:diet_tracker/pages/products.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int currentPageIndex = 0;
  final List<Widget> pages = [const DiariesPage(), const ProductsPage()];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: theme.primaryColorLight,
        indicatorColor: theme.primaryColorDark,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'דוחות',
          ),
          NavigationDestination(
            icon: Icon(Icons.storage),
            label: 'מוצרים',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
