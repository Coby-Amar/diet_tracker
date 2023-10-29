import 'package:flutter/material.dart';

class TableCellText extends StatelessWidget {
  final String label;
  final TextStyle? style;
  const TableCellText({
    super.key,
    required this.label,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}
