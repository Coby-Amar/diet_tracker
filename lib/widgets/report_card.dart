import 'package:diet_tracker/providers/models.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final Report report;
  const ReportCard({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = report.date;
    final day = date.day;
    final month = date.month;
    final year = date.year;
    return Card(
      child: Column(
        children: [
          Text(
            report.formattedDate,
            style: TextStyle(
              color: theme.primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          ...report.entries.map((entry) => Text(entry.toDisplayString))
        ],
      ),
    );
  }
}
