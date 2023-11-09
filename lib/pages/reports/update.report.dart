import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/products.dart';
import 'package:diet_tracker/resources/stores/reports.dart';
import 'package:diet_tracker/widgets/form/date_picker_form_field.dart';
import 'package:diet_tracker/widgets/form/report_entry_field.form.dart';

class UpdateReportPage extends StatelessWidget {
  const UpdateReportPage({super.key});

  _onFormSuccess(DisplayReportWithEntries model, ReportsStore reportStore) =>
      (BuildContext? context) async {
        model.calculateReportTotals(shouldResetTotals: true);
        await reportStore.update(model);
        return true;
      };

  List<ReportEntryFormField> _createNewEntries(
    DisplayReportWithEntries model,
  ) =>
      List.filled(
        15 - model.existingEntries.length,
        ReportEntryFormField(
          onSaved: (entryData) {
            if (entryData == null) return;
            final entry = DisplayEntry.from(
              entryData.apiProduct!,
              entryData.amount!,
            );
            model.entriesToCreate.add(entry);
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    final reportStore = context.read<ReportsStore>();
    final report = GoRouterState.of(context).extra as ApiReport;
    return FutureBuilder(
        future: reportStore.loadEntries(report.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data?.isEmpty ?? true) {
            return const Text("error no data");
          }
          final products = context.read<ProductsStore>().products;
          final model =
              DisplayReportWithEntries.fromApi(report, snapshot.data!);
          return ScaffoldForm(
            title: "עדכון דוח",
            formSubmitText: "עדכן",
            onSuccess: _onFormSuccess(model, reportStore),
            formBuilder: (theme, validations) => Column(
              children: [
                DatePicketFormField(
                  label: 'date',
                  initialValue: model.report.date,
                  onSaved: (date) => model.report.date = date!,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "פריטים קימים",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        ...model.existingEntries.map(
                          (entry) => ReportEntryFormField(
                            initialValue: ReportEntryFormFieldState(
                              entry.getProduct(products),
                              entry.amount,
                            ),
                            onSaved: (entryData) {
                              if (entryData == null) return;
                              entry.productId = entryData.apiProduct!.id;
                              entry.amount = entryData.amount!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "פריטים חדשים",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        ..._createNewEntries(model),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
