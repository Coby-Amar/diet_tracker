import 'package:diet_tracker/pages/products/create.product.dart';
import 'package:diet_tracker/pages/products/update.product.dart';
import 'package:diet_tracker/pages/reports/update.report.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/app.dart';
import 'package:diet_tracker/pages/home.dart';
import 'package:diet_tracker/pages/login.dart';
import 'package:diet_tracker/pages/products/products.dart';
import 'package:diet_tracker/pages/register.dart';
import 'package:diet_tracker/pages/reports/reports.dart';
import 'package:diet_tracker/pages/reports/create.report.dart';
import 'package:diet_tracker/pages/settings.dart';
import 'package:diet_tracker/resources/stores/info.dart';

final goRouterConfig = GoRouter(
  navigatorKey: rootNavigationKey,
  initialLocation: "/login",
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: "login",
      path: "/login",
      redirect: (context, state) async {
        final infoStore = context.read<InfoStore>();
        await infoStore.getUser();
        if (infoStore.isLoggedIn) {
          return "/";
        }
        return null;
      },
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: "register",
      path: "/register",
      builder: (context, state) => const RegisterPage(),
    ),
    ShellRoute(
        parentNavigatorKey: rootNavigationKey,
        navigatorKey: homeNavigationKey,
        builder: (context, state, child) => HomePage(child: child),
        routes: [
          GoRoute(
            name: "home",
            path: "/",
            pageBuilder: (context, state) =>
                NoTransitionPage(child: ErrorWidget(Exception())),
            redirect: (context, state) {
              if (state.fullPath == "/") {
                return "/products";
              }
              return null;
            },
            routes: [
              GoRoute(
                parentNavigatorKey: rootNavigationKey,
                name: "settings",
                path: "settings",
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
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
                builder: (context, state) => CreateProductPage(),
              ),
              GoRoute(
                parentNavigatorKey: rootNavigationKey,
                name: "update_product",
                path: "update",
                builder: (context, state) => UpdateProductPage(),
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
                builder: (context, state) => CreateReportPage(),
              ),
              GoRoute(
                parentNavigatorKey: rootNavigationKey,
                name: "update_report",
                path: "update",
                builder: (context, state) => UpdateReportPage(),
              ),
            ],
          ),
        ]),
  ],
);
