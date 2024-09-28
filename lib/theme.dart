import 'package:flutter/material.dart';

final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blueGrey);

final theme = ThemeData(
  colorScheme: colorScheme,
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  }),
  textTheme: Typography.blackRedwoodCity.copyWith(
    headlineLarge: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w900,
    ),
    headlineMedium: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900,
    ),
    headlineSmall: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w900,
    ),
    titleLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
  ),
  scaffoldBackgroundColor: Colors.blueGrey,
  listTileTheme: const ListTileThemeData(tileColor: Colors.white),
  useMaterial3: true,
);
