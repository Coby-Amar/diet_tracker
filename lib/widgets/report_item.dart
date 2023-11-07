import 'package:diet_tracker/resources/formatters/numbers.dart';
import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/stores/info.dart';
import 'package:diet_tracker/widgets/report_table.dart';
import 'package:diet_tracker/widgets/table_cell_text.dart';
import 'package:diet_tracker/widgets/table_cell_text_header_footer.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ReportItem extends StatelessWidget {
  final ApiReport report;
  final VoidCallback onView;
  final VoidCallback onEdit;
  const ReportItem({
    super.key,
    required this.report,
    required this.onView,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.read<InfoStore>().user!;
    return InkWell(
      onTap: onView,
      onDoubleTap: onEdit,
      child: Card(
        color: theme.cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                report.formattedDate,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            ReportTable(
              header: const [
                TableCellTextHeaderFooter(label: ""),
                TableCellTextHeaderFooter(label: "פחממות"),
                TableCellTextHeaderFooter(label: "חלבון"),
                TableCellTextHeaderFooter(label: "שומן"),
              ],
              entries: [
                TableRow(
                  children: [
                    const TableCellText(label: "סכום"),
                    TableCellText(
                      label:
                          NumbersFormmater.toFixed2(report.carbohydratesTotal),
                    ),
                    TableCellText(
                      label: NumbersFormmater.toFixed2(report.proteinsTotal),
                    ),
                    TableCellText(
                      label: NumbersFormmater.toFixed2(report.fatsTotal),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const TableCellText(label: "מותר"),
                    TableCellText(label: user.carbohydrate),
                    TableCellText(label: user.protein),
                    TableCellText(label: user.fat),
                  ],
                ),
              ],
              footer: [
                const TableCellTextHeaderFooter(label: "נותר"),
                TableCellReportItemRemainingText(
                  limit: user.dailyLimits.carbohydrate,
                  total: report.carbohydratesTotal,
                ),
                TableCellReportItemRemainingText(
                  limit: user.dailyLimits.protein,
                  total: report.proteinsTotal,
                ),
                TableCellReportItemRemainingText(
                  limit: user.dailyLimits.fat,
                  total: report.fatsTotal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TableCellReportItemRemainingText extends StatelessWidget {
  final int limit;
  final double total;

  const TableCellReportItemRemainingText({
    super.key,
    required this.limit,
    required this.total,
  });

  bool get isOverLimit {
    return limit < total;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isOverLimit ? theme.colorScheme.error : Colors.green;
    return TableCell(
      child: Text(
        (limit - total).abs().toStringAsFixed(2),
        style: theme.textTheme.titleMedium?.copyWith(color: color),
        textAlign: TextAlign.center,
      ),
    );
  }
}
