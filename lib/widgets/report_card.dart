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
    return Card(
      child: Column(
        children: [
          Container(
            width: Size.infinite.width,
            color: theme.focusColor,
            child: Center(
              heightFactor: 2,
              child: Text(
                report.formattedDate,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Text(
            'פחממות = ${report.carbohydrates.toStringAsFixed(1)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'חלבון = ${report.proteins.toStringAsFixed(1)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'שומן = ${report.fats.toStringAsFixed(1)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// class EntryRow extends StatelessWidget {
//   final EntryModel entry;
//   const EntryRow({super.key, required this.entry});

//   @override
//   Widget build(BuildContext context) {
//     return TableRow(
//       children: [
//           //       Text(
//           //         report.formattedDate,
//           //         style: const TextStyle(fontWeight: FontWeight.bold)
//           // ),
//       ],
//     );
//   }
// }
