import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models/create.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/reports.dart';
import 'package:diet_tracker/widgets/create_entry.dart';
import 'package:diet_tracker/widgets/date_picker_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateUpdateReportDialog extends StatefulWidget {
  final DisplayReport? report;
  const CreateUpdateReportDialog({
    super.key,
    this.report,
  });

  @override
  State<CreateUpdateReportDialog> createState() =>
      _CreateUpdateReportDialogState();
}

class _CreateUpdateReportDialogState extends State<CreateUpdateReportDialog> {
  final _model = CreateUpdateReportWithEntries.empty();

  onCreateEntrySaved(CreateUpdateEntry? entry) {
    if (entry == null) return null;
    setState(() => _model.entries.add(entry));
  }

  CreateUpdateReportWithEntries onFormSuccess() {
    final report = _model.report;
    report.carbohydratesTotal = 0;
    report.proteinsTotal = 0;
    report.fatsTotal = 0;
    for (final entry in _model.entries) {
      report.carbohydratesTotal += entry.carbohydrates;
      report.proteinsTotal += entry.proteins;
      report.fatsTotal += entry.fats;
    }
    return _model;
  }

  _loadReport() async {
    final report = widget.report!;
    final reportsStore = context.read<ReportsStore>();
    final entries = await reportsStore.loadEntries(report);
    if (entries?.isNotEmpty ?? false) {
      _model.fromDisplay(DisplayReportWithEntries(report, entries!));
    }
    setState(() {});
  }

  Widget _buildEntries() {
    int itemCount = 15;
    Widget? Function(BuildContext, int) itemBuilder =
        (context, index) => CreateUpdateReportEntry(
              onSaved: onCreateEntrySaved,
              onDelete: (p0) => {},
            );
    if (isUpdate) {
      itemCount = _model.entries.length;
      itemBuilder = (context, index) => CreateUpdateReportEntry(
            entry: _model.entries[index],
            onSaved: onCreateEntrySaved,
            onDelete: (p0) => {},
          );
    }
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 10),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }

  bool get isUpdate => widget.report != null;

  @override
  void initState() {
    if (isUpdate) {
      _loadReport();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DialogScaffoldForm(
        title: isUpdate ? "עדכון דוח" : 'יצירת דוח',
        formSubmitText: isUpdate ? "עדכן" : "צור",
        onSuccess: onFormSuccess,
        formBuilder: (theme, validations) => Column(
          children: [
            DatePicketFormField(
              label: 'date',
              onSaved: (date) => setState(() => _model.report.date = date!),
            ),
            Expanded(
              child: _buildEntries(),
            ),
          ],
        ),
      );
}
