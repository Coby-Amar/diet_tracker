import 'package:flutter/material.dart';

final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blueGrey);

final theme = ThemeData(
  colorScheme: colorScheme,
  scaffoldBackgroundColor: Colors.blueGrey,
  listTileTheme: const ListTileThemeData(tileColor: Colors.white),
  useMaterial3: true,
);
