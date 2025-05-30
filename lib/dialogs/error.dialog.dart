import 'package:flutter/material.dart';

class ErrorDialog extends SnackBar {
  const ErrorDialog({
    super.key,
    required super.content,
    super.backgroundColor = const Color(0xffE24666),
    super.behavior = SnackBarBehavior.floating,
  });
}

mixin OpenError {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
          BuildContext context, ErrorDialog errorDialog) =>
      ScaffoldMessenger.of(context).showSnackBar(errorDialog);
}
