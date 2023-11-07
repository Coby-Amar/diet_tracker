import 'package:diet_tracker/mixins/routing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarThemed extends StatelessWidget
    with Routing
    implements PreferredSizeWidget {
  final String title;
  final bool showActions;
  const AppBarThemed({
    super.key,
    required this.title,
    this.showActions = false,
  });

  @override
  AppBar build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      centerTitle: true,
      backgroundColor: theme.primaryColorLight,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: theme.primaryColorDark,
        ),
      ),
      actions: showActions
          ? [
              IconButton(
                  onPressed: () => context.pushNamed("settings"),
                  icon: Icon(
                    Icons.settings,
                    color: theme.primaryColorDark,
                  ))
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
