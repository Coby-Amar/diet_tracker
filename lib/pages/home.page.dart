import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentPageTitle = 'דוחות';
  int currentPageIndex = 0;

  void _onDestinationSelected(int index) {
    final appProvider = context.read<AppProvider>();
    appProvider.searchReportsQuery = '';
    appProvider.searchProductsQuery = '';
    var pageTitle = 'דוחות';
    switch (index) {
      case 0:
        context.goNamed("reports");
        break;
      case 1:
        pageTitle = 'מוצרים';
        context.goNamed("products");
        break;
      // case 2:
      //   pageTitle = 'Calculator';
      //   context.goNamed("calculator");
      case 2:
        pageTitle = 'הגדרות';
        context.goNamed("settings");
        break;
    }
    setState(() {
      currentPageIndex = index;
      currentPageTitle = pageTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBarThemed(
        title: currentPageTitle,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onDestinationSelected,
        backgroundColor: theme.primaryColorLight,
        indicatorColor: theme.primaryColorDark,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.summarize_outlined),
            icon: Icon(Icons.summarize_outlined),
            label: 'דוחות',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'מוצרים',
          ),
          // NavigationDestination(
          //   icon: Icon(Icons.calculate),
          //   label: 'Calculator',
          // ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'הגדרות',
          ),
        ],
      ),
      body: widget.child,
    );
  }
}
