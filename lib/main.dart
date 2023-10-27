import 'dart:io';

import 'package:diet_tracker/app.dart';
import 'package:diet_tracker/resources/stores/info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:diet_tracker/resources/stores/products.dart';
import 'package:diet_tracker/resources/stores/reports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    await windowManager.ensureInitialized();
    await windowManager.setTitle("Diet Tracker");
    await windowManager.setMinimumSize(const Size(600, 600));
  }

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => InfoStore()),
        Provider(create: (context) => ProductsStore()),
        Provider(create: (context) => ReportsStore()),
      ],
      child: const Application(),
    ),
  );
  await windowManager.maximize();
}
