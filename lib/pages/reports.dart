import 'package:diet_tracker/providers/models.dart';
import 'package:diet_tracker/providers/reports.dart';
import 'package:diet_tracker/widgets/create_edit_report.dart';
import 'package:diet_tracker/widgets/report_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiariesPage extends StatelessWidget {
  const DiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ReportsProvider>();
    final reports = provider.reports;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.primaryColorLight,
        title: Text(
          'דוחות',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: theme.primaryColorDark,
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: reports.map((report) => ReportCard(report: report)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Report? result = await showDialog(
            context: context,
            builder: (context) => const CreateEditReportDialog(),
          );
          if (result != null) {
            provider.createReport(result);
          }
        },
        backgroundColor: theme.primaryColorDark,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: theme.primaryColorLight,
        ),
      ),
    );
  }
}
