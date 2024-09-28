import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:diet_tracker/resources/extensions/files.extention.dart';
import 'package:diet_tracker/resources/extensions/numbers.extension.dart';
import 'package:diet_tracker/resources/models.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;

  const ProductItem({
    super.key,
    required this.product,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onEdit,
        leading: product.image != null
            ? InkWell(
                onTap: () => context.pushNamed(
                  'fullscreen_image',
                  extra: product.image,
                ),
                child: product.image.widgetOrNull,
              )
            : null,
        title: Text(product.name),
        subtitle: Text('${product.quantity.toDisplay} ${product.units}'),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fat: ${product.fats.toDisplay}',
            ),
            Text(
              'Protein: ${product.proteins.toDisplay}',
            ),
            Text(
              'Carbohydrate: ${product.carbohydrates.toDisplay}',
            ),
          ],
        ),
      );
}
