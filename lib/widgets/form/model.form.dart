import 'dart:async';

import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/validations.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef SubmitForm = void Function(BuildContext context);

typedef FormBuilder<M extends BaseModel> = List<Widget> Function(
    ThemeData theme, Validations validations, M model, SubmitForm submitForm);
typedef FormOnSuccess<M extends BaseModel> = FutureOr<Object?> Function(
    M model);

class ModelForm<M extends BaseModel> extends StatelessWidget {
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

  void submitForm(BuildContext context) async {
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...formBuilder(theme, Validations(), model, submitForm),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(buttonIcon),
            label: Text(buttonLabel),
            onPressed: () => submitForm(context),
          ),
        ],
      ),
    );
  }
}
