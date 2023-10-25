import 'package:diet_tracker/dialogs/are_you_sure.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidablePageItem extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final Widget child;
  const SlidablePageItem({
    super.key,
    required this.onEdit,
    required this.onUpdate,
    required this.onDelete,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Slidable(
      key: super.key,
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: theme.colorScheme.primary,
            icon: Icons.preview_outlined,
            onPressed: (context) => onEdit(),
            label: "פרטים",
          ),
          SlidableAction(
            backgroundColor: const Color(0xFFFFD55E),
            icon: Icons.edit_outlined,
            onPressed: (context) => onUpdate(),
            label: "עריכה",
          ),
          SlidableAction(
            backgroundColor: theme.colorScheme.error,
            icon: Icons.delete_forever_outlined,
            onPressed: (context) async {
              final bool? response = await showDialog(
                context: context,
                builder: (context) => const AreYouSureDialogs(),
              );
              if (response ?? false) {
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
