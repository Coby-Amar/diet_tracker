import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/info.dart';
import 'package:flutter/material.dart';

import 'package:diet_tracker/widgets/slideable_page_item.dart';
import 'package:provider/provider.dart';

typedef ReportItemEventFunc = void Function(DisplayReport report);

class ReportItem extends StatelessWidget {
  final DisplayReport report;
  final ReportItemEventFunc onEdit;
  final ReportItemEventFunc onUpdate;
  final ReportItemEventFunc onDelete;
  const ReportItem({
    super.key,
    required this.report,
    required this.onEdit,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.read<InfoStore>().user!;
    return SlidablePageItem(
      onEdit: () => onEdit(report),
      onDelete: () => onDelete(report),
      onUpdate: () => onUpdate(report),
      child: Container(
        color: theme.cardColor,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                report.formattedDate,
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Table(
                children: [
                  const TableRow(
                    children: [
                      TableCell(
                        child: Text(""),
                      ),
                      TableCell(
                        child: Text("מותר"),
                      ),
                      TableCell(
                        child: Text("סכום"),
                      ),
                      TableCell(
                        child: Text("נותר"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const TableCell(child: Text("פחממות")),
                      TableCell(child: Text(user.carbohydrateString)),
                      TableCell(child: Text(report.carbohydratesTotalString)),
                      TableCell(
                        child: ReportItemRemainingText(
                          limit: user.carbohydrate,
                          total: report.carbohydratesTotal,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const TableCell(child: Text("חלבון")),
                      TableCell(child: Text(user.proteinString)),
                      TableCell(child: Text(report.proteinsTotalString)),
                      TableCell(
                        child: ReportItemRemainingText(
                          limit: user.protein,
                          total: report.proteinsTotal,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const TableCell(child: Text("שומן")),
                      TableCell(child: Text(user.fatString)),
                      TableCell(child: Text(report.fatsTotalString)),
                      TableCell(
                        child: ReportItemRemainingText(
                          limit: user.fat,
                          total: report.fatsTotal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportItemRemainingText extends StatelessWidget {
  final int limit;
  final double total;

  const ReportItemRemainingText({
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
    final color = isOverLimit ? theme.colorScheme.error : Colors.lightGreen;
    return Text(
      (limit - total).toStringAsFixed(2),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.end,
      style: TextStyle(
        color: color,
      ),
    );
  }
}
