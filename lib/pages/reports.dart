import 'package:diet_tracker/dialogs/create_report.dart';
import 'package:diet_tracker/dialogs/view_report.dart';
import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/resources/models/create.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/reports.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:diet_tracker/widgets/floating_add_button.dart';
import 'package:diet_tracker/widgets/report_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ReportsPage extends StatelessWidget with Dialogs {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reportsStore = context.read<ReportsStore>();
    final reports = reportsStore.reports;
    return Scaffold(
      appBar: const AppBarThemed(
        title: 'דוחות',
        showActions: true,
      ),
      body: Observer(
          builder: (_) => GridView.count(
                crossAxisCount: 2,
                children: reports
                    .map((report) => ReportItem(
                          onView: () => openDialog(
                            context,
                            ViewReportDialog(report: report),
                          ),

                          onEdit: () async {
                            await openDialog(
                              context,
                              const CreateReportDialog(),
                            );
                          },
                          // onDelete: () => reportsStore.delete(report.id),
                          report: report,
                        ))
                    .toList(),
              )),
      floatingActionButton: FloatingAddButton(
        onPressed: () async {
          final CreateReportWithEntries? result = await openDialog(
            context,
            const CreateReportDialog(),
          );
          if (result != null) {
            reportsStore.create(result);
            // provider.createReport(result);
          }
        },
      ),
    );
  }
}
