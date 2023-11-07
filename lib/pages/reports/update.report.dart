import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/products.dart';
import 'package:diet_tracker/resources/stores/reports.dart';
import 'package:diet_tracker/widgets/date_picker_form_field.dart';
import 'package:diet_tracker/widgets/form/report_entry_field.form.dart';

class UpdateReportPage extends StatelessWidget {
  final List<DisplayEntry> entriesToCreate = [];
  UpdateReportPage({super.key});

  // Future<bool> onFormSuccess(
  //   BuildContext? context,
  // ) async {
  //   final report = _model.report;
  //   for (final entry in _model.entries) {
  //     report.carbohydratesTotal += entry.carbohydrates;
  //     report.proteinsTotal += entry.proteins;
  //     report.fatsTotal += entry.fats;
  //   }
  //   if (context != null) {
  //     final reportsStore = context.read<ReportsStore>();
  //     await reportsStore.create(_model);
  //   }
  //   return true;
  // }

  onCreateEntrySaved(DisplayReportWithEntries model, int index) =>
      (ReportEntryFormFieldState? entry) {
        if (entry == null) return null;
        model.entries[index].amount = entry.amount!;
        model.entries[index].productId = entry.apiProduct!.id;
      };

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
            onSuccess: (_) async {
              print(model);
              // await reportStore.update(model);
              return true;
            },
            formBuilder: (theme, validations) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DatePicketFormField(
                  label: 'date',
                  onSaved: (date) => model.report.date = date!,
                ),
                ...model.entries.map(
                  (entry) => ReportEntryFormField(
                    initialValue: ReportEntryFormFieldState(
                      products.firstWhere(
                          (product) => product.id == entry.productId),
                      entry.amount,
                    ),
                    onSaved: (entryData) {
                      if (entryData == null) return;
                      entry.productId = entryData.apiProduct!.id;
                      entry.amount = entryData.amount!;
                    },
                  ),
                ),
                TextButton(
                  child: const Text("הוספת פריט"),
                  onPressed: () {
                    entriesToCreate.add(DisplayEntry());
                  },
                ),
                ...entriesToCreate.map(
                  (entry) => ReportEntryFormField(
                    onSaved: (entryData) {
                      if (entryData == null) return;
                      entry.productId = entryData.apiProduct!.id;
                      entry.amount = entryData.amount!;
                    },
                  ),
                ),
                // Expanded(
                //   child: Builder(builder: (context) {
                //     return ListView.builder(
                //       padding: const EdgeInsets.only(bottom: 10),
                //       itemCount: model.entries.length,
                //       itemBuilder: (context, index) => ReportEntryFormField(
                //         initialValue: ReportEntryFormFieldState(
                //           products.firstWhere((element) =>
                //               element.id == model.entries[index].productId),
                //           model.entries[index].amount,
                //         ),
                //         onSaved: onCreateEntrySaved(model, index),
                //       ),
                //     );
                //   }),
                // ),
              ],
            ),
          );
        });
  }
}
