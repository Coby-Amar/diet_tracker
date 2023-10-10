import 'package:diet_tracker/providers/models.dart';
import 'package:flutter/material.dart';

class ReportItem extends StatelessWidget {
  final Report report;
  const ReportItem({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
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
                Text(report.carbohydrates.toStringAsFixed(1)),
                Text(report.proteins.toStringAsFixed(1)),
                Text(report.fats.toStringAsFixed(1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
