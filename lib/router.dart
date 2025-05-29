import 'package:diet_tracker/pages/products/create_update.product.dart';
import 'package:diet_tracker/pages/reports/create_update.report.dart';
import 'package:diet_tracker/pages/settings/daily_limit.page.dart';
import 'package:diet_tracker/pages/settings/settings.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:diet_tracker/app.dart';
import 'package:diet_tracker/pages/home.page.dart';
import 'package:diet_tracker/pages/products/products.page.dart';
import 'package:diet_tracker/pages/reports/reports.page.dart';
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
      navigatorKey: homeNavigationKey,
      builder: (context, state, child) => HomePage(child: child),
      routes: [
        GoRoute(
            name: "settings",
            path: "/settings",
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SettingsPage()),
            routes: [
              GoRoute(
                parentNavigatorKey: rootNavigationKey,
                name: "daily_limit",
                path: "/daily_limit",
                builder: (context, state) => const DailyLimitPage(),
              ),
            ]),
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
              builder: (context, state) => const CreateUpdateProductPage(),
            ),
            GoRoute(
              parentNavigatorKey: rootNavigationKey,
              name: "update_product",
              path: "update",
              builder: (context, state) => const CreateUpdateProductPage(),
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
              builder: (context, state) => const CreateUpdateReportPage(),
            ),
            GoRoute(
              parentNavigatorKey: rootNavigationKey,
              name: "update_report",
              path: "update",
              builder: (context, state) => const CreateUpdateReportPage(),
            ),
          ],
        ),
        GoRoute(
          name: "calculator",
          path: "/calculator",
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: Text("Not Built Yet")),
        ),
      ],
    ),
  ],
);
