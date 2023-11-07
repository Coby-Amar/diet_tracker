import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/resources/stores/info.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget with Dialogs {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final infoStore = context.read<InfoStore>();
    return Scaffold(
      appBar: const AppBarThemed(title: 'הגדרות'),
      body: ListView(
        children: [
          ListTile(
            tileColor: Colors.red,
            textColor: Colors.white,
            title: const Text('התנתק'),
            trailing: const Icon(Icons.logout_outlined, color: Colors.white),
            onTap: () async {
              final goNamed = context.goNamed;
              final response = await openAreYouSureDialog(context);
              if (response) {
                await infoStore.logout();
                if (!infoStore.isLoggedIn) {
                  goNamed("login");
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
