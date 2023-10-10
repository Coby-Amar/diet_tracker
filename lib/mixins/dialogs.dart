import 'dart:async';

import 'package:flutter/material.dart';

typedef DailogCallback<T> = Future<T?> Function();

mixin Dialogs {
  Future<T?> openDialog<T>(BuildContext context, Widget dialog) => showDialog(
        context: context,
        builder: (context) => dialog,
      );

  DailogCallback<T> openDialogOnPressed<T>(
          BuildContext context, Widget dialog) =>
      () => openDialog<T>(context, dialog);
}
