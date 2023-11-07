import 'package:diet_tracker/mouse_events.dart';
import 'package:diet_tracker/router.dart';
import 'package:diet_tracker/shortcuts_actions.dart';
import 'package:diet_tracker/theme.dart';
import 'package:flutter/material.dart';

final rootNavigationKey =
    GlobalKey<NavigatorState>(debugLabel: "rootNavigationKey");
final homeNavigationKey =
    GlobalKey<NavigatorState>(debugLabel: "homeNavigationKey");

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: goRouterConfig,
        theme: theme,
        builder: (context, child) {
          if (child == null) {
            return ErrorWidget(
              Exception("Oops something went wrong should not be here"),
            );
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
        },
      );
}
