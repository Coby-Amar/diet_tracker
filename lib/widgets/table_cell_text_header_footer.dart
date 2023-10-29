import 'package:flutter/material.dart';

class TableCellTextHeaderFooter extends StatelessWidget {
  final String label;
  const TableCellTextHeaderFooter({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TableCell(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: theme.textTheme.titleMedium,
      ),
    );
  }

  // const TableCellText({super.key});
}
