import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const Application(),
    ),
  );
}
