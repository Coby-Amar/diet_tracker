import 'package:flutter/material.dart';

class AreYouSureDialogs extends StatelessWidget {
  const AreYouSureDialogs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    return AlertDialog(
      backgroundColor: theme.dialogBackgroundColor,
      title: const Center(child: Text("האם את/ה בטוח?")),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => navigator.pop(true),
          child: Text(
            "כן",
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ),
        TextButton(
          onPressed: () => navigator.pop(false),
          child: Text(
            "לא",
            style: TextStyle(color: theme.primaryColorDark),
          ),
        )
      ],
    );
  }
}
