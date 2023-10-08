import 'package:diet_tracker/providers/models.dart';
import 'package:diet_tracker/widgets/create_edit_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/providers/products.dart';
import 'package:diet_tracker/widgets/product_item.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ProductsProvider>();
    final products = provider.products;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: theme.primaryColorDark,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColorLight,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ProductItem(product: products[index]),
        itemCount: products.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ProductModel? result = await showDialog(
            context: context,
            builder: (context) => const CreateEditProductDialog(),
          );
          if (result != null) {
            if (result.id != 0) {
              provider.updateProduct(result);
            } else {
              provider.createProduct(result);
            }
          }
        },
        backgroundColor: theme.primaryColorDark,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: theme.primaryColorLight,
        ),
      ),
    );
  }
}
