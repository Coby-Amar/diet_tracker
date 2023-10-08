import 'package:flutter/material.dart';

import 'package:diet_tracker/providers/models.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).cardColor,
      isThreeLine: true,
      // leading: product.image != null ? Image.file(File(product.image!)) : null,
      title: Text(
        product.name,
        style: const TextStyle(fontSize: 24),
      ),
      subtitle: Text(
        'כמות: ${product.amount}',
        style: const TextStyle(fontSize: 18),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'פחמהמה: ${product.carbohydrate}',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Text(
            'חלבון: ${product.protein}',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Text(
            'שומן: ${product.fat}',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
