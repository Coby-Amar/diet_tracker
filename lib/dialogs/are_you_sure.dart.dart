import 'package:flutter/material.dart';

class AreYouSureDialog extends StatelessWidget {
  final String title;
  final String? content;
  const AreYouSureDialog({
    super.key,
    this.title = "האם את/ה בטוח?",
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    return AlertDialog(
      backgroundColor: theme.dialogBackgroundColor,
      title: Center(
          child: Text(
        title,
        style: theme.textTheme.headlineMedium,
      )),
      content: content != null
          ? Center(
              heightFactor: 1,
              child: Text(
                content!,
                style: theme.textTheme.titleMedium,
              ),
            )
          : null,
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
