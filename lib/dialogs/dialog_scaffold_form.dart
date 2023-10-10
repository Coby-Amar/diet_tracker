import 'package:diet_tracker/validations.dart';
import 'package:flutter/material.dart';

typedef FormBuilder = Widget Function(ThemeData theme, Validations validations);
typedef FormOnSucces<T> = T Function();

class DialogScaffoldForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FormBuilder formBuilder;
  final FormOnSucces onSuccess;
  final String title;
  final String formSubmitText;
  DialogScaffoldForm({
    super.key,
    required this.formBuilder,
    required this.onSuccess,
    required this.title,
    this.formSubmitText = 'צור',
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
            ElevatedButton(
              onPressed: () {
                final result = _formKey.currentState?.validate();
                if (result == null || !result) {
                  return;
                }
                _formKey.currentState?.save();
                Navigator.of(context).pop(onSuccess());
              },
              child: Text(formSubmitText),
            )
          ],
        ),
      ),
    );
  }
}
