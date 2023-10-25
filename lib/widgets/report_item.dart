import 'package:flutter/material.dart';

import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/widgets/slideable_page_item.dart';

typedef ReportItemEventFunc = void Function(ReportModel report);

class ReportItem extends StatelessWidget {
  final ReportModel report;
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
    print(super.key);
    final theme = Theme.of(context);
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
              ),
            ),
            const Column(
              children: [
                Text('פחממות'),
                Text('חלבון'),
                Text('שומן'),
              ],
            ),
            const Column(
              children: [
                Text('מותר'),
                Text('פחממות'),
                Text('חלבון'),
                Text('שומן'),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Text(report.carbohydratesTotal.toStringAsFixed(1)),
                  Text(report.proteinsTotal.toStringAsFixed(1)),
                  Text(report.fatsTotal.toStringAsFixed(1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
