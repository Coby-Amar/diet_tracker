import 'package:diet_tracker/mouse_events.dart';
import 'package:diet_tracker/pages/home.dart';
import 'package:diet_tracker/pages/login.dart';
import 'package:diet_tracker/pages/register.dart';
import 'package:diet_tracker/pages/settings.dart';
import 'package:diet_tracker/pages/splash.dart';
import 'package:diet_tracker/shortcuts_actions.dart';
import 'package:diet_tracker/theme.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>(debugLabel: "navigatorKey");

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      navigatorKey: navigatorKey,
      theme: theme,
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashPage(),
        'login': (context) => const LoginPage(),
        'register': (context) => const RegisterPage(),
        'home': (context) => const HomePage(),
        'settings': (context) => const SettingsPage(),
      },
      builder: (context, child) {
        if (child == null) {
          return ErrorWidget(
              Exception("Oops something went wrong should not be here"));
        }
        return Listener(
          onPointerDown: onPointerDown,
          child: FocusableActionDetector(
            shortcuts: ShortcutsAndActions.backShortcuts,
            actions: ShortcutsAndActions.backShortcutsActions,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: child,
            ),
          ),
        );
      });
}
