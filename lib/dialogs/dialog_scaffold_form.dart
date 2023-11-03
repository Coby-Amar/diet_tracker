import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/resources/models/create.dart';
import 'package:diet_tracker/validations.dart';
import 'package:flutter/material.dart';

typedef FormBuilder = Widget Function(ThemeData theme, Validations validations);
typedef FormOnSuccess<T extends CreationModel> = T Function();

class DialogScaffoldForm extends StatelessWidget with Dialogs {
  final _formKey = GlobalKey<FormState>();
  final FormBuilder formBuilder;
  final FormOnSuccess onSuccess;
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
                onPressed: () {
                  final result = _formKey.currentState?.validate();
                  if (result == null || !result) {
                    return;
                  }
                  _formKey.currentState?.save();
                  Navigator.of(context).pop(onSuccess());
                },
                child: Text(formSubmitText),
              ),
            )
          ],
        ),
      ),
    );
  }
}
