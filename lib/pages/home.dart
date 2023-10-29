import 'package:diet_tracker/pages/reports.dart';
import 'package:diet_tracker/pages/products.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  final List<Widget> pages = [const ProductsPage(), const ReportsPage()];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) => setState(
          () => currentPageIndex = index,
        ),
        backgroundColor: theme.primaryColorLight,
        indicatorColor: theme.primaryColorDark,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.storage),
            label: 'מוצרים',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.summarize_outlined),
            icon: Icon(Icons.summarize_outlined),
            label: 'דוחות',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
