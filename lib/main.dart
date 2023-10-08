import 'package:diet_tracker/providers/reports.dart';
import 'package:diet_tracker/providers/products.dart';
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
      ChangeNotifierProvider(
        create: (_) => ReportsProvider(),
        lazy: false,
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        scaffoldBackgroundColor: Colors.blueGrey,
        useMaterial3: true,
      ),
    );
  }
}
