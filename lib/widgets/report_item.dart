import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/info.dart';
import 'package:diet_tracker/widgets/report_table.dart';
import 'package:diet_tracker/widgets/table_cell_text.dart';
import 'package:diet_tracker/widgets/table_cell_text_header_footer.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ReportItem extends StatelessWidget {
  final DisplayReport report;
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
                    TableCellText(label: report.carbohydratesTotalString),
                    TableCellText(label: report.proteinsTotalString),
                    TableCellText(label: report.fatsTotalString),
                  ],
                ),
                TableRow(
                  children: [
                    const TableCellText(label: "מותר"),
                    TableCellText(label: user.carbohydrateString),
                    TableCellText(label: user.proteinString),
                    TableCellText(label: user.fatString),
                  ],
                ),
              ],
              footer: [
                const TableCellTextHeaderFooter(label: "נותר"),
                TableCellReportItemRemainingText(
                  limit: user.carbohydrate,
                  total: report.carbohydratesTotal,
                ),
                TableCellReportItemRemainingText(
                  limit: user.protein,
                  total: report.proteinsTotal,
                ),
                TableCellReportItemRemainingText(
                  limit: user.fat,
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
