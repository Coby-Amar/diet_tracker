import 'package:flutter/material.dart';

class AppBarThemed extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showActions;
  const AppBarThemed({
    super.key,
    required this.title,
    this.actions = const [],
    this.showActions = false,
  });
  @override
  State<AppBarThemed> createState() => _AppBarThemedState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarThemedState extends State<AppBarThemed> {
  bool showSearch = false;
  @override
  AppBar build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      centerTitle: true,
      backgroundColor: theme.primaryColorLight,
      actions: widget.actions,
      title: Text(
        widget.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: theme.primaryColorDark,
        ),
      ),
    );
  }
}
