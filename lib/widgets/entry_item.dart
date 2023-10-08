import 'package:flutter/material.dart';

class EntryItem extends StatelessWidget {
  const EntryItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Column(
        children: [
          Text(
            'day',
            style: TextStyle(
              color: theme.primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
