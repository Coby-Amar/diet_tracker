import 'package:diet_tracker/resources/extensions/dates.extension.dart';
import 'package:flutter/material.dart';

class DatePickerFormField extends StatelessWidget {
  final String label;
  final DateTime? initialValue;
  final void Function(DateTime? date) onSaved;
  DatePickerFormField({
    super.key,
    required this.label,
    required this.onSaved,
    this.initialValue,
  });

  final _today = DateTime.now();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = (initialValue ?? _today).toDayMonthYear;
    return FormField<DateTime>(
      onSaved: onSaved,
      initialValue: initialValue ?? _today,
      builder: (field) {
        _controller.text = (field.value ?? _today).toDayMonthYear;
        return TextFormField(
          readOnly: true,
          controller: _controller,
          onTap: () async {
            final result = await showDatePicker(
              context: context,
              initialDate: initialValue ?? _today,
              firstDate: _today.add(-const Duration(days: 365)),
              lastDate: _today,
            );
            if (result != null) {
              field.didChange(result);
              _controller.text = result.toDayMonthYear;
            }
          },
          decoration: InputDecoration(
            label: Text(label),
            suffixIcon: const Icon(Icons.calendar_month),
          ),
        );
      },
    );
  }
}
