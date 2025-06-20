import 'package:diet_tracker/resources/provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            ListTile(
              leading: Icon(Icons.import_export),
              title: Text("ייצא"),
              onTap: () => context.read<AppProvider>().exportProducts(),
            ),
            ListTile(
              leading: Icon(Icons.storage_outlined),
              title: Text("מכסה יומי"),
              onTap: () => context.goNamed("daily_limit"),
            )
          ],
        ),
      );
}
