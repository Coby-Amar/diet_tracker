import 'package:diet_tracker/dialogs/create_product.dart';
import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/providers/models.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:diet_tracker/widgets/floating_add_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/providers/products.dart';
import 'package:diet_tracker/widgets/product_item.dart';

class ProductsPage extends StatelessWidget with Dialogs {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductsProvider>();
    final products = provider.products;
    return Scaffold(
      appBar: const AppBarThemed(
        title: 'מוצרים',
        showActions: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ProductItem(product: products[index]),
        itemCount: products.length,
        separatorBuilder: (context, index) => const Divider(),
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () async {
          final ProductModel? result = await openDialog(
            context,
            const CreateProductDialog(),
          );
          if (result != null) {
            provider.createProduct(result);
          }
        },
      ),
    );
  }
}
