import 'package:flutter/material.dart';

class CheckboxFormField extends StatelessWidget {
  final String label;
  final bool? initialValue;
  final void Function(bool? value) onSaved;
  const CheckboxFormField({
    super.key,
    required this.initialValue,
    required this.label,
    required this.onSaved,
  });
  @override
  Widget build(BuildContext context) => FormField<bool>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSaved: onSaved,
        initialValue: initialValue,
        builder: (field) => CheckboxListTile(
          title: Text(label),
          value: field.value,
          onChanged: (value) => field.didChange(value),
        ),
      );
}
