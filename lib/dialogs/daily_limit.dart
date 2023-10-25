import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models.dart';
import 'package:flutter/material.dart';

class DailyLimit extends StatelessWidget {
  const DailyLimit({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogScaffoldForm(
      title: 'הגבלה יומי',
      onSuccess: () {
        return const BaseModel(id: 'id');
      },
      formBuilder: (theme, validations) => Column(
        children: [
          TextFormField(),
        ],
      ),
    );
  }
}
