import 'package:diet_tracker/resources/extensions/numbers.extension.dart';
import 'package:flutter/material.dart';

import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/resources/extensions/dates.extension.dart';

class ReportItem extends StatelessWidget {
  final Report report;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const ReportItem({
    super.key,
    required this.report,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onEdit,
        onLongPress: onDelete,
        title: Text(report.date.toDayMonthYear),
        subtitle: Text('Entries: ${report.entries.length}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('שומן: ${report.totalFats.toDisplay}'),
            Text('חלבון: ${report.totalProteins.toDisplay}'),
            Text('פחממה: ${report.totalCarbohydrates.toDisplay}'),
          ],
        ),
      );
}
