import 'dart:io';

import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/widgets/slideable_page_item.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final DisplayProduct product;
  final VoidCallback onEdit;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  const ProductItem({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SlidablePageItem(
      onEdit: onEdit,
      onDelete: onDelete,
      onUpdate: onUpdate,
      child: Container(
        color: theme.cardColor,
        width: Size.infinite.width,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            product.image != null
                ? Image.file(
                    File(product.image ?? ''),
                    fit: BoxFit.contain,
                    height: 50,
                  )
                : null,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  product.name,
                  style: theme.textTheme.headlineLarge,
                ),
                Text(
                  'כמות: ${product.amount}',
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'פחמהמה: ${product.carbohydrate}',
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  'חלבון: ${product.protein}',
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  'שומן: ${product.fat}',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }
}
