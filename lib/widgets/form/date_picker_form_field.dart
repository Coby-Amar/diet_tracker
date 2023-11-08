import 'package:diet_tracker/resources/formatters/date.dart';
import 'package:flutter/material.dart';

class DatePicketFormField extends StatelessWidget {
  final String label;
  final DateTime? initialValue;
  final void Function(DateTime? date) onSaved;
  DatePicketFormField({
    super.key,
    required this.label,
    required this.onSaved,
    this.initialValue,
  });

  final _today = DateTime.now();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      onSaved: onSaved,
      initialValue: initialValue ?? _today,
      builder: (field) {
        return TextFormField(
          controller: _controller
            ..text = DateFormmater.toDayMonthYear(initialValue ?? _today),
          onChanged: (value) => _controller.text = value,
          readOnly: true,
          onTap: () async {
            final result = await showDatePicker(
              context: context,
              initialDate: _today,
              firstDate: _today.add(-const Duration(days: 365)),
              lastDate: _today,
            );
            if (result != null) {
              field.didChange(result);
              _controller.text = DateFormmater.toDayMonthYear(result);
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
