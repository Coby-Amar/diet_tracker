import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/widgets/create_entry.dart';
import 'package:diet_tracker/widgets/date_picker_form_field.dart';
import 'package:flutter/material.dart';

class CreateReportDialog extends StatefulWidget {
  const CreateReportDialog({super.key});

  @override
  State<CreateReportDialog> createState() => _CreateReportDialogState();
}

class _CreateReportDialogState extends State<CreateReportDialog> {
  DateTime _date = DateTime.now();
  int _entryCount = 1;
  final List<EntryModel> _entryies = [];

  onCreateEntrySaved(CreateEntryFormFieldValue? entryData) {
    final product = entryData!.product!;
    final entryAmount = entryData.amount;
    final amount = entryAmount / product.amount;
    final entry = EntryModel(
      productId: entryData.product!.id,
      amount: entryAmount,
      carbohydrates: amount * product.carbohydrate,
      proteins: amount * product.protein,
      fats: amount * product.fat,
    );
    setState(() => _entryies.add(entry));
  }

  ReportWithEntries onFormSuccess() {
    double carbohydratesTotal = 0;
    double proteinsTotal = 0;
    double fatsTotal = 0;
    for (final entry in _entryies) {
      carbohydratesTotal += entry.carbohydrates;
      proteinsTotal += entry.proteins;
      fatsTotal += entry.fats;
    }
    final report = ReportModel(
      date: _date,
      carbohydratesTotal: carbohydratesTotal,
      proteinsTotal: proteinsTotal,
      fatsTotal: fatsTotal,
    );
    return ReportWithEntries(report: report, entries: _entryies);
  }

  @override
  Widget build(BuildContext context) => DialogScaffoldForm(
        title: 'יצירת דוח',
        onSuccess: onFormSuccess,
        formBuilder: (theme, validations) => Column(
          children: [
            DatePicketFormField(
              label: 'date',
              onSaved: (date) => setState(() => _date = date!),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: _entryCount < 15
                        ? () => setState(() => _entryCount++)
                        : null,
                    child: const Text("הוספת פריט"),
                  ),
                  TextButton(
                    onPressed: _entryCount > 1
                        ? () => setState(() => _entryCount--)
                        : null,
                    child: const Text("הסיר פריט"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 10),
                itemCount: _entryCount,
                itemBuilder: (context, index) => CreateEntry(
                  date: _date,
                  onSaved: onCreateEntrySaved,
                  onDelete: (p0) => {},
                ),
              ),
            ),
          ],
        ),
      );
}
