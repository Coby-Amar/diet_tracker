import 'package:diet_tracker/dialogs/daily_limit.dart';
import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget with Dialogs {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      ListTile(
        title: const Text('שיני הגבלה יומיות'),
        trailing: IconButton(
            onPressed: openDialogOnPressed(context, const DailyLimit()),
            icon: const Icon(Icons.abc)),
      ),
    ];
    return Scaffold(
      appBar: const AppBarThemed(title: 'הגדרות'),
      body: ListView.separated(
        itemBuilder: (context, index) => options[index],
        itemCount: options.length,
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
