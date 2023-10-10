import 'package:flutter/material.dart';

final _today = DateTime.now();

class DatePicketFormField extends StatelessWidget {
  final String label;
  final void Function(DateTime? date) onSaved;
  DatePicketFormField({
    super.key,
    required this.label,
    required this.onSaved,
  });
  final _controller = TextEditingController(
    text: '${_today.day}/${_today.month}/${_today.year}',
  );

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      onSaved: onSaved,
      initialValue: _today,
      builder: (field) {
        return TextFormField(
          controller: _controller,
          onChanged: (value) => _controller.text = value,
          readOnly: true,
          onTap: () async {
            final result = await showDatePicker(
              context: context,
              initialDate: _today,
              firstDate: _today,
              lastDate: DateTime(_today.year + 1, _today.month, _today.day),
            );
            if (result != null) {
              field.didChange(result);
              _controller.text = '${result.day}/${result.month}/${result.year}';
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
