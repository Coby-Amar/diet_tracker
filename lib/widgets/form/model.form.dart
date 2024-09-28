import 'dart:async';

import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/validations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef FormBuilder<M extends JsonObject> = List<Widget> Function(
    ThemeData theme, Validations validations, M model);
typedef FormOnSuccess<M extends JsonObject> = FutureOr<Object?> Function(
    M model);

class ModelForm<M extends JsonObject> extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FormOnSuccess<M> onSuccess;
  final M model;
  final FormBuilder<M> formBuilder;
  final String buttonLabel;
  final IconData buttonIcon;
  final bool canPop;
  ModelForm({
    super.key,
    required this.model,
    required this.formBuilder,
    required this.onSuccess,
    required this.buttonLabel,
    this.buttonIcon = Icons.add,
    this.canPop = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...formBuilder(theme, Validations(), model),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(buttonIcon),
            label: Text(buttonLabel),
            onPressed: () async {
              final result = _formKey.currentState?.validate();
              if (result == null || !result) {
                return;
              }
              _formKey.currentState?.save();
              final pop = context.pop;
              final response = await onSuccess(model);
              if (canPop) {
                pop(response);
              }
            },
          ),
        ],
      ),
    );
  }
}
