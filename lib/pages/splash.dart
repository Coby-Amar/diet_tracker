import 'dart:async';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/stores/info.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigation = Navigator.of(context);
    final infoStore = context.read<InfoStore>();
    return EasySplashScreen(
      logo: Image.network(
          'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
      title: const Text(
        "Title",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: theme.primaryColorLight,
      futureNavigator: () async {
        await infoStore.getUser();
        if (infoStore.isLoggedIn) {
          navigation.pushReplacementNamed("home");
        }
        return Future.value(Object());
      }(),
    );
  }
}
