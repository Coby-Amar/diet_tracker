import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidablePageItem extends StatelessWidget with Dialogs {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Widget child;
  const SlidablePageItem({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Slidable(
      key: super.key,
      startActionPane: ActionPane(
        extentRatio: 0.5,
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: const Color(0xFFFFD55E),
            icon: Icons.edit_outlined,
            onPressed: (context) => onEdit(),
            label: "עריכה",
          ),
          SlidableAction(
            backgroundColor: theme.colorScheme.error,
            icon: Icons.delete_forever_outlined,
            onPressed: (context) async {
              final response = await openAreYouSureDialog(context);
              if (response) {
                onDelete();
              }
            },
            label: "מחק",
          ),
        ],
      ),
      child: child,
    );
  }
}
