import 'package:diet_tracker/dialogs/create_report.dart';
import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/providers/models.dart';
import 'package:diet_tracker/providers/reports.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:diet_tracker/widgets/floating_add_button.dart';
import 'package:diet_tracker/widgets/report_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportsPage extends StatelessWidget with Dialogs {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<ReportsProvider>();
    // final reports = provider.reports;
    final reports = [];
    return Scaffold(
      appBar: const AppBarThemed(
        title: 'דוחות',
        showActions: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ReportItem(report: reports[index]),
        itemCount: reports.length,
        separatorBuilder: (context, index) => const Divider(),
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () async {
          final Report? result = await openDialog(
            context,
            const CreateReportDialog(),
          );
          if (result != null) {
            // provider.createReport(result);
          }
        },
      ),
    );
  }
}
