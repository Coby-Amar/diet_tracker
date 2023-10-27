import 'dart:async';

import 'package:diet_tracker/resources/stores/info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  FutureOr<dynamic> Function() authCheck(infoStore, navigation) => () async {
        await infoStore.getUser();
        if (infoStore.loggedIn) {
          navigation.pushReplacementNamed("home");
        }
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigation = Navigator.of(context);
    final infoStore = context.read<InfoStore>();
    Future.delayed(
      const Duration(milliseconds: 700),
      authCheck(infoStore, navigation),
    );
    return Container(
      color: theme.primaryColorLight,
      child: const Center(
        child: Text("Diet tracker"),
      ),
    );
  }
}
