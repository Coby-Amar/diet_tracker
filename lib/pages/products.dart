import 'package:diet_tracker/dialogs/create_product.dart';
import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/resources/stores/products.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:diet_tracker/widgets/floating_add_button.dart';
import 'package:flutter/material.dart';

import 'package:diet_tracker/widgets/product_item.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget with Dialogs {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productsStore = context.read<ProductsStore>();
    return Scaffold(
      appBar: const AppBarThemed(
        title: 'מוצרים',
        showActions: true,
      ),
      body: Observer(
        builder: (_) => ListView.separated(
          itemBuilder: (context, index) => ProductItem(
            product: productsStore.products[index],
            onEdit: () {},
            onUpdate: () => {},
            onDelete: () =>
                productsStore.delete(productsStore.products[index].id),
          ),
          itemCount: productsStore.products.length,
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () async {
          final result = await openDialog<ProductModel>(
            context,
            const CreateProductDialog(),
          );
          if (result != null) {
            productsStore.create(result);
          }
        },
      ),
    );
  }
}
