import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/reports.dart';
import 'package:diet_tracker/widgets/create_entry.dart';
import 'package:diet_tracker/widgets/date_picker_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateReportPage extends StatelessWidget {
  final _model = DisplayReportWithEntries();
  CreateReportPage({super.key});

  Future<bool> onFormSuccess(
    BuildContext? context,
  ) async {
    final report = _model.report;
    final entries = _model.entries;
    if (entries.isEmpty) {
      await showDialog(
          context: context!,
          builder: (context) => const AlertDialog(
                title: Text("חייב לפחות מוצר 1"),
              ));
      return false;
    }
    for (final entry in _model.entries) {
      report.carbohydratesTotal += entry.carbohydrates;
      report.proteinsTotal += entry.proteins;
      report.fatsTotal += entry.fats;
    }
    if (context != null) {
      final reportsStore = context.read<ReportsStore>();
      await reportsStore.create(_model);
      return true;
    }
    return false;
  }

  onCreateEntrySaved(DisplayEntry? entry) {
    if (entry == null) return null;
    _model.entries.add(entry);
  }

  @override
  Widget build(BuildContext context) => ScaffoldForm(
        title: "יצירת דוח",
        formSubmitText: "צור",
        onSuccess: onFormSuccess,
        formBuilder: (theme, validations) => Column(
          children: [
            DatePicketFormField(
              label: 'date',
              onSaved: (date) => _model.report.date = date!,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 10),
                itemCount: 15,
                itemBuilder: (context, index) => CreateUpdateReportEntry(
                  onSaved: onCreateEntrySaved,
                  onDelete: (p0) => {},
                ),
              ),
            ),
          ],
        ),
      );
}
