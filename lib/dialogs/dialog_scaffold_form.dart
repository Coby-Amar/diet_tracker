import 'dart:async';

import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/validations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef FormBuilder = Widget Function(ThemeData theme, Validations validations);
typedef FormOnSuccess = FutureOr<bool> Function(BuildContext? context);

class ScaffoldForm<T> extends StatelessWidget with Dialogs {
  final _formKey = GlobalKey<FormState>();
  final FormBuilder formBuilder;
  final FormOnSuccess onSuccess;
  final String title;
  final String formSubmitText;
  final Widget? floatingActionButton;
  ScaffoldForm({
    super.key,
    required this.title,
    required this.onSuccess,
    required this.formBuilder,
    this.formSubmitText = 'צור',
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Form(
        // onWillPop: () => openAreYouSureDialog(context),
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: theme.cardColor,
                child: formBuilder(theme, Validations()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  final result = _formKey.currentState?.validate();
                  if (result == null || !result) {
                    return;
                  }
                  _formKey.currentState?.save();
                  final canPop = context.canPop();
                  final pop = context.pop;
                  final response = await onSuccess(_formKey.currentContext);
                  if (response && canPop) {
                    pop();
                  }
                },
                child: Text(formSubmitText),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
