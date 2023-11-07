import 'dart:async';

import 'package:diet_tracker/dialogs/are_you_sure.dart.dart';
import 'package:flutter/material.dart';

typedef DailogCallback<T> = Future<T?> Function();

mixin Dialogs {
  Future<T?> openDialog<T>(BuildContext context, Widget dialog) => showDialog(
        context: context,
        useSafeArea: true,
        builder: (context) => dialog,
      );

  Future<bool> openAreYouSureDialog<bool>(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const AreYouSureDialog(),
    );
    if (result == null) {
      return false as Future<bool>;
    }
    return result;
  }

  DailogCallback<T> openDialogOnPressed<T>(
          BuildContext context, Widget dialog) =>
      () => openDialog<T>(context, dialog);
}
