import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            ListTile(
              leading: Icon(Icons.storage_outlined),
              title: Text("מכסה יומי"),
              onTap: () => context.goNamed("daily_limit"),
            )
          ],
        ),
      );
}
