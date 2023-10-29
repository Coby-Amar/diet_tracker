import 'package:diet_tracker/dialogs/are_you_sure.dart.dart';
import 'package:diet_tracker/dialogs/daily_limit.dart';
import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/resources/stores/info.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget with Dialogs {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = Navigator.of(context);
    final infoStore = context.read<InfoStore>();
    return Scaffold(
      appBar: const AppBarThemed(title: 'הגדרות'),
      body: ListView(
        children: [
          ListTile(
            tileColor: Colors.red,
            textColor: Colors.white,
            title: const Text('התנתק'),
            trailing: IconButton(
              onPressed: openDialogOnPressed(context, const DailyLimit()),
              icon: const Icon(Icons.logout_outlined, color: Colors.white),
            ),
            onTap: () async {
              final response = await openAreYouSureDialog(context);
              if (response) {
                await infoStore.logout();
                if (!infoStore.loggedIn) {
                  navigation.pushReplacementNamed("login");
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
