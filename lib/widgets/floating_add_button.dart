import 'dart:async';

import 'package:flutter/material.dart';

typedef FloatingAddButtonPressed = FutureOr<void> Function();

class FloatingAddButton extends StatelessWidget {
  final FloatingAddButtonPressed onPressed;
  const FloatingAddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: theme.primaryColorDark,
      onPressed: onPressed,
      child: Icon(
        Icons.add,
        color: theme.primaryColorLight,
      ),
    );
  }
}
