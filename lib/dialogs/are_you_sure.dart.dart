import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AreYouSureDialog extends StatelessWidget {
  final String title;
  final String? content;
  const AreYouSureDialog({
    super.key,
    this.title = "Are you sure?",
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          onPressed: () => context.pop(true),
          child: Text(
            "Yes",
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ),
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(
            "No",
            style: TextStyle(color: theme.primaryColorDark),
          ),
        )
      ],
    );
  }
}
