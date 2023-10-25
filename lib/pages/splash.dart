import 'dart:async';

import 'package:diet_tracker/resources/stores/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  FutureOr<dynamic> Function() authCheck(authStore, navigation) => () async {
        await authStore.checkIfLoggedIn();
        if (authStore.loggedIn) {
          navigation.pushReplacementNamed("home");
        }
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigation = Navigator.of(context);
    final authStore = context.read<AuthStore>();
    Future.delayed(
      const Duration(milliseconds: 700),
      authCheck(authStore, navigation),
    );
    return Container(
      color: theme.primaryColorLight,
      child: const Center(
        child: Text("Diet tracker"),
      ),
    );
  }
}
