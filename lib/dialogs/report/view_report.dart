import 'package:diet_tracker/resources/stores/reports.dart';
import 'package:diet_tracker/widgets/report_table.dart';
import 'package:diet_tracker/widgets/table_cell_text.dart';
import 'package:diet_tracker/widgets/table_cell_text_header_footer.dart';
import 'package:flutter/material.dart';

import 'package:diet_tracker/resources/models/display.dart';
import 'package:provider/provider.dart';

class ViewReportDialog extends StatelessWidget {
  final DisplayReport report;
  const ViewReportDialog({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reportsStore = context.read<ReportsStore>();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                report.formattedDate,
                style: theme.textTheme.headlineLarge,
              ),
            ),
            FutureBuilder(
              future: reportsStore.loadEntries(report),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return const Text("no Data");
                  }
                  return Card(
                    child: ReportTable(
                      header: const [
                        TableCellTextHeaderFooter(label: "כמות"),
                        TableCellTextHeaderFooter(label: "פחממה"),
                        TableCellTextHeaderFooter(label: "חלבון"),
                        TableCellTextHeaderFooter(label: "שומן"),
                      ],
                      entries: snapshot.data!.map((entry) => TableRow(
                            children: [
                              TableCellText(label: entry.amountString),
                              TableCellText(label: entry.carbohydratesString),
                              TableCellText(label: entry.proteinsString),
                              TableCellText(label: entry.fatsString),
                            ],
                          )),
                      footer: [
                        const TableCellTextHeaderFooter(label: "סכום"),
                        TableCellTextHeaderFooter(
                          label: report.carbohydratesTotalString,
                        ),
                        TableCellTextHeaderFooter(
                          label: report.proteinsTotalString,
                        ),
                        TableCellTextHeaderFooter(
                          label: report.fatsTotalString,
                        ),
                      ],
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
