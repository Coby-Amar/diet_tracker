import 'package:diet_tracker/dialogs/create_report.dart';
import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/resources/models/create.dart';
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
          builder: (_) => ListView.separated(
                itemBuilder: (context, index) => ReportItem(
                  onEdit: (report) {},
                  onUpdate: (report) {},
                  onDelete: (report) => reportsStore.delete(report.id),
                  report: reports[index],
                ),
                itemCount: reports.length,
                separatorBuilder: (context, index) => const Divider(),
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
