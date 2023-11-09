import 'package:diet_tracker/resources/formatters/numbers.dart';
import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/products.dart';
import 'package:diet_tracker/resources/stores/reports.dart';
import 'package:diet_tracker/widgets/report_table.dart';
import 'package:diet_tracker/widgets/table_cell_text.dart';
import 'package:diet_tracker/widgets/table_cell_text_header_footer.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ViewReportDialog extends StatelessWidget {
  final ApiReport report;
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
              future: reportsStore.loadEntries(report.id).then((entries) =>
                  DisplayReportWithEntries.fromApi(report, entries ?? [])),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final data = snapshot.data;
                if (snapshot.data == null) {
                  return const Text("no Data");
                }
                final existingEntries = data!.existingEntries;
                final totalAmount = data.totalAmount;
                final products = context.read<ProductsStore>().products;
                return Card(
                  child: ReportTable(
                    columnWidths: const {2: FlexColumnWidth(1.5)},
                    header: const [
                      TableCellTextHeaderFooter(label: "שם"),
                      TableCellTextHeaderFooter(label: "כמות"),
                      TableCellTextHeaderFooter(label: "פחממה"),
                      TableCellTextHeaderFooter(label: "חלבון"),
                      TableCellTextHeaderFooter(label: "שומן"),
                    ],
                    entries: existingEntries.map((entry) => TableRow(
                          children: [
                            TableCellText(
                              label: entry.getProduct(products).name,
                            ),
                            TableCellText(label: entry.amount.toString()),
                            TableCellText(
                              label: NumbersFormmater.toFixed2(
                                entry.carbohydrates,
                              ),
                            ),
                            TableCellText(
                              label: NumbersFormmater.toFixed2(entry.proteins),
                            ),
                            TableCellText(
                                label: NumbersFormmater.toFixed2(entry.fats)),
                          ],
                        )),
                    footer: [
                      const TableCellTextHeaderFooter(label: "סכום"),
                      TableCellTextHeaderFooter(
                        label: totalAmount.toString(),
                      ),
                      TableCellTextHeaderFooter(
                        label: NumbersFormmater.toFixed2(
                          report.carbohydratesTotal,
                        ),
                      ),
                      TableCellTextHeaderFooter(
                        label: NumbersFormmater.toFixed2(report.proteinsTotal),
                      ),
                      TableCellTextHeaderFooter(
                        label: NumbersFormmater.toFixed2(report.fatsTotal),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
