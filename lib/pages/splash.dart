import 'package:diet_tracker/pages/login.dart';
import 'package:diet_tracker/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLoggedIn =
        context.select<AuthProvider, bool>((provider) => provider.isLoggedIn);
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        final navigation = Navigator.of(context);
        if (isLoggedIn) {
          navigation.pushReplacementNamed("home");
        } else {
          navigation.pushReplacementNamed("login");
        }
      },
    );
    return Container(
      color: theme.primaryColorLight,
      child: const Center(
        child: Text("Diet tracker"),
      ),
    );
  }
}
