import 'package:diet_tracker/resources/models.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final ReportModel report;
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
            'פחממות = ${report.carbohydratesTotal.toStringAsFixed(1)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'חלבון = ${report.proteinsTotal.toStringAsFixed(1)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'שומן = ${report.fatsTotal.toStringAsFixed(1)}',
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
