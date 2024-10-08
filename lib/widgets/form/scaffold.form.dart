import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/validations.dart';

typedef FormBuilder<M extends JsonObject> = Widget Function(ThemeData theme,
    Validations validations, M model, void Function(VoidCallback) setState);
typedef FormOnSuccess<M extends JsonObject> = FutureOr<Object?> Function(
    M model);

class ScaffoldForm<M extends JsonObject> extends StatefulWidget {
  final FormBuilder<M> formBuilder;
  final FormOnSuccess<M> onSuccess;
  final M model;
  final String title;
  final String formSubmitText;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  const ScaffoldForm({
    super.key,
    required this.model,
    required this.title,
    required this.onSuccess,
    required this.formBuilder,
    this.formSubmitText = 'Add',
    this.actions,
    this.floatingActionButton,
  });

  @override
  State<ScaffoldForm> createState() => _ScaffoldFormState<M>();
}

class _ScaffoldFormState<M extends JsonObject> extends State<ScaffoldForm<M>> {
  final _formKey = GlobalKey<FormState>();

  M get model => widget.model;
  List<Widget>? get actions => widget.actions;
  String get formSubmitText => widget.formSubmitText;
  String get title => widget.title;
  FormBuilder<M> get formBuilder => widget.formBuilder;
  FormOnSuccess<M> get onSuccess => widget.onSuccess;
  Widget? get floatingActionButton => widget.floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: theme.textTheme.headlineLarge,
        ),
        centerTitle: true,
        actions: actions,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: theme.cardColor,
                child: SingleChildScrollView(
                  child: formBuilder(theme, Validations(), model, setState),
                ),
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
                  final response = await onSuccess(model);
                  if (canPop) {
                    pop(response);
                  }
                },
                child: Text(formSubmitText),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
