import 'package:diet_tracker/pages/settings.dart';
import 'package:diet_tracker/providers/entries.dart';
import 'package:diet_tracker/providers/reports.dart';
import 'package:diet_tracker/providers/products.dart';
import 'package:diet_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/pages/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ProductsProvider(),
        lazy: false,
      ),
      Provider(
        create: (_) => EntriesProvider(),
        lazy: false,
      ),
      ChangeNotifierProxyProvider<EntriesProvider, ReportsProvider>(
        create: (_) => ReportsProvider(null),
        update: (_, entries, __) => ReportsProvider(entries),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
      home: const AppPage(),
      theme: theme,
      routes: {
        'settings': (context) => const SettingsPage(),
      },
    );
  }
}
