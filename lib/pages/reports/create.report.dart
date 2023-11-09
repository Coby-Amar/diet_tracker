import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/reports.dart';
import 'package:diet_tracker/widgets/form/date_picker_form_field.dart';
import 'package:diet_tracker/widgets/form/report_entry_field.form.dart';

class CreateReportPage extends StatelessWidget {
  final _model = DisplayReportWithEntries();
  CreateReportPage({super.key});

  Future<bool> onFormSuccess(
    BuildContext? context,
  ) async {
    final entries = _model.entriesToCreate;
    if (entries.isEmpty) {
      await showDialog(
          context: context!,
          builder: (context) => const AlertDialog(
                title: Text("חייב לפחות מוצר 1"),
              ));
      return false;
    }
    if (context != null) {
      final reportsStore = context.read<ReportsStore>();
      await reportsStore.create(_model);
      return true;
    }
    return false;
  }

  onCreateEntrySaved(ReportEntryFormFieldState? entryData) {
    if (entryData == null) return null;
    final entry = DisplayEntry.from(entryData.apiProduct!, entryData.amount!);
    _model.entriesToCreate.add(entry);
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
                itemBuilder: (context, index) => ReportEntryFormField(
                  onSaved: onCreateEntrySaved,
                ),
              ),
            ),
          ],
        ),
      );
}
