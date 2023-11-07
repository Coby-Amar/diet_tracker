import 'package:diet_tracker/dialogs/view_report.dart';
import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/resources/stores/reports.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:diet_tracker/widgets/floating_add_button.dart';
import 'package:diet_tracker/widgets/report_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ReportsPage extends StatelessWidget with Dialogs {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reportStore = context.read<ReportsStore>();
    final reports = reportStore.reports;
    // final reportsStore = context.read<ReportsStore>();
    // final reports = reportsStore.reports;
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
                          report: report,
                          onView: () => openDialog(
                            context,
                            ViewReportDialog(report: report),
                          ),
                          onEdit: () => context.goNamed(
                            "update_report",
                            extra: report,
                          ),
                          // onDelete: () => reportsStore.delete(report.id),
                        ))
                    .toList(),
              )),
      floatingActionButton: FloatingAddButton(
        onPressed: () => context.goNamed("create_report"),
      ),
    );
  }
}
