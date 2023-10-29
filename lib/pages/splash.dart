import 'dart:async';
import 'package:diet_tracker/pages/home.dart';
import 'package:diet_tracker/pages/login.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/stores/info.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final navigation = Navigator.of(context);
    final infoStore = context.read<InfoStore>();
    return EasySplashScreen(
      // color: theme.primaryColorLight,
      // child: const Center(
      //   child: Text("Diet tracker"),
      // ),
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
      // showLoader: true,
      // loadingText: const Text("Loading..."),
      futureNavigator: Future.delayed(
        const Duration(milliseconds: 700),
        () async {
          await infoStore.getUser();
          if (infoStore.loggedIn) {
            return Future.value(const HomePage());
          }
          return Future.value(const LoginPage());
        },
      ),
      // futureNavigator: futureCall(infoStore, navigation),
    );
  }
}
