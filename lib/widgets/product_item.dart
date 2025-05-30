import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:diet_tracker/resources/extensions/numbers.extension.dart';
import 'package:diet_tracker/resources/models.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductItem({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onEdit,
        onLongPress: onDelete,
        leading: InkWell(
          child: product.imageOrDefault,
          onTap: () => context.pushNamed(
            'fullscreen_image',
            extra: product.image,
          ),
        ),
        title: Text(product.name),
        subtitle:
            Text('${product.quantity.toDisplay} ${product.units.translation}'),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'שומן: ${product.fats.toDisplay}',
            ),
            Text(
              'חלבון: ${product.proteins.toDisplay}',
            ),
            Text(
              'פחממה: ${product.carbohydrates.toDisplay}',
            ),
          ],
        ),
      );
}
