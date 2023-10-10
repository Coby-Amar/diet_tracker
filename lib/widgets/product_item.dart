import 'dart:io';

import 'package:flutter/material.dart';

import 'package:diet_tracker/providers/models.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.cardColor,
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
    );
  }
}
