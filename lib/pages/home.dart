import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  _onDestinationSelected(int index) {
    switch (index) {
      case 0:
        context.goNamed("reports");
        break;
      case 1:
        context.goNamed("products");
    }
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onDestinationSelected,
        backgroundColor: theme.primaryColorLight,
        indicatorColor: theme.primaryColorDark,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.summarize_outlined),
            icon: Icon(Icons.summarize_outlined),
            label: 'Reports',
          ),
          NavigationDestination(
            icon: Icon(Icons.storage),
            label: 'Products',
          ),
        ],
      ),
      body: widget.child,
    );
  }
}
