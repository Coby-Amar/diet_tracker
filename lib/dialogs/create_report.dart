import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models/create.dart';
import 'package:diet_tracker/widgets/create_entry.dart';
import 'package:diet_tracker/widgets/date_picker_form_field.dart';
import 'package:flutter/material.dart';

class CreateReportDialog extends StatefulWidget {
  const CreateReportDialog({super.key});

  @override
  State<CreateReportDialog> createState() => _CreateReportDialogState();
}

class _CreateReportDialogState extends State<CreateReportDialog> {
  final CreateReportWithEntries _model = CreateReportWithEntries.empty();

  onCreateEntrySaved(CreateEntry? entry) {
    if (entry == null) return null;
    setState(() => _model.entries.add(entry));
  }

  CreateReportWithEntries onFormSuccess() {
    for (final entry in _model.entries) {
      _model.report.carbohydratesTotal += entry.carbohydrates;
      _model.report.proteinsTotal += entry.proteins;
      _model.report.fatsTotal += entry.fats;
    }
    return _model;
  }

  @override
  Widget build(BuildContext context) => DialogScaffoldForm(
        title: 'יצירת דוח',
        onSuccess: onFormSuccess,
        formBuilder: (theme, validations) => Column(
          children: [
            DatePicketFormField(
              label: 'date',
              onSaved: (date) => setState(() => _model.report.date = date!),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: Row(
            //     children: [
            //       TextButton(
            //         onPressed: _entryCount < 15
            //             ? () => setState(() => _entryCount++)
            //             : null,
            //         child: const Text("הוספת פריט"),
            //       ),
            //       TextButton(
            //         onPressed: _entryCount > 1
            //             ? () => setState(() => _entryCount--)
            //             : null,
            //         child: const Text("הסיר פריט"),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 10),
                itemCount: 15,
                itemBuilder: (context, index) => CreateReportEntry(
                  onSaved: onCreateEntrySaved,
                  onDelete: (p0) => {},
                ),
              ),
            ),
          ],
        ),
      );
}
