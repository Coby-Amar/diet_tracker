import 'dart:async';

import 'package:flutter/material.dart';

typedef NavigationCallback<T> = Future<T?> Function();

mixin Routing {
  Future<T?> navigateToNamed<T>(BuildContext context, String route) =>
      Navigator.of(context).pushNamed<T>(route);

  NavigationCallback<T> onPressedNavigateToNamed<T>(
          BuildContext context, String route) =>
      () => navigateToNamed<T>(context, route);
}
