import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/app.dart';

void logErrorsToFile() async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    runApp(
      ChangeNotifierProvider(
        create: (context) => AppProvider(),
        child: const Application(),
      ),
    );
  } catch (e) {
    final root = await getApplicationDocumentsDirectory();
    final errorFile = File(join(root.path, 'error.log'));
    if (!errorFile.existsSync()) {
      errorFile.createSync();
    }
    await errorFile.writeAsString(e.toString());
  }
}
