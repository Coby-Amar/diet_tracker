import 'package:diet_tracker/router.dart';
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
        debugShowCheckedModeBanner: false,
        routerConfig: goRouterConfig,
        theme: theme,
        builder: (context, child) {
          if (child == null) {
            return ErrorWidget(
              Exception("Oops something went wrong should not be here"),
            );
          }
          return child;
        },
      );
}
