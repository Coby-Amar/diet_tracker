import 'package:diet_tracker/pages/login.dart';
import 'package:diet_tracker/pages/settings.dart';
import 'package:diet_tracker/pages/splash.dart';
import 'package:diet_tracker/providers/api.dart';
import 'package:diet_tracker/providers/auth.dart';
import 'package:diet_tracker/providers/products.dart';
import 'package:diet_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/pages/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      Provider(
        create: (_) => APIProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductsProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>(debugLabel: "navigatorKey");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
      theme: theme,
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashPage(),
        'login': (context) => const LoginPage(),
        'home': (context) => const AppPage(),
        'settings': (context) => const SettingsPage(),
      },
    );
  }
}
