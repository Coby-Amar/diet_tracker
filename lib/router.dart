import 'package:diet_tracker/pages/reports/update.report.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:diet_tracker/app.dart';
import 'package:diet_tracker/pages/home.dart';
import 'package:diet_tracker/pages/products/products.dart';
import 'package:diet_tracker/pages/reports/reports.dart';
import 'package:diet_tracker/pages/products/create.product.dart';
import 'package:diet_tracker/pages/products/update.product.dart';
import 'package:diet_tracker/pages/reports/create.report.dart';
import 'package:diet_tracker/pages/fullscreen_image.dart';

class DismissKeyboardNavigationObserver extends NavigatorObserver {
  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.didStartUserGesture(route, previousRoute);
  }
}

final goRouterConfig = GoRouter(
  navigatorKey: rootNavigationKey,
  initialLocation: "/reports",
  observers: [DismissKeyboardNavigationObserver()],
  routes: [
    GoRoute(
      parentNavigatorKey: rootNavigationKey,
      name: "fullscreen_image",
      path: '/image',
      builder: (context, state) => const FullScreenImagePage(),
    ),
    ShellRoute(
      parentNavigatorKey: rootNavigationKey,
      navigatorKey: homeNavigationKey,
      builder: (context, state, child) => HomePage(child: child),
      routes: [
        GoRoute(
          name: "products",
          path: "/products",
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProductsPage()),
          routes: [
            GoRoute(
              parentNavigatorKey: rootNavigationKey,
              name: "create_product",
              path: "create",
              builder: (context, state) => const CreateProductPage(),
            ),
            GoRoute(
              parentNavigatorKey: rootNavigationKey,
              name: "update_product",
              path: "update",
              builder: (context, state) => const UpdateProductPage(),
            ),
          ],
        ),
        GoRoute(
          name: "reports",
          path: "/reports",
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ReportsPage()),
          routes: [
            GoRoute(
              parentNavigatorKey: rootNavigationKey,
              name: "create_report",
              path: "create",
              builder: (context, state) => const CreateReportPage(),
            ),
            GoRoute(
              parentNavigatorKey: rootNavigationKey,
              name: "update_report",
              path: "update",
              builder: (context, state) => const UpdateReportPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
