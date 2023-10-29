import 'package:flutter/material.dart';

class ReportTable extends StatelessWidget {
  final List<Widget> header;
  final List<Widget> footer;
  final Iterable<TableRow> entries;
  const ReportTable({
    super.key,
    required this.header,
    required this.footer,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.cardColor,
      child: Table(
        columnWidths: const {1: FlexColumnWidth(1.5)},
        children: [
          TableRow(
            decoration: BoxDecoration(color: theme.primaryColorLight),
            children: header,
          ),
          ...entries,
          TableRow(
            decoration: BoxDecoration(color: theme.primaryColorLight),
            children: footer,
          )
        ],
      ),
    );
  }
}
