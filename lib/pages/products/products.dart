import 'package:diet_tracker/mixins/dialogs.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/products.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:diet_tracker/widgets/floating_add_button.dart';
import 'package:flutter/material.dart';

import 'package:diet_tracker/widgets/product_item.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget with Dialogs {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productsStore = context.read<ProductsStore>();
    final products = productsStore.products;
    return Scaffold(
      appBar: const AppBarThemed(
        title: 'מוצרים',
        showActions: true,
      ),
      body: Observer(
        builder: (_) => ListView.separated(
          itemCount: products.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) => ProductItem(
            product: products[index],
            onEdit: () => context.goNamed(
              "update_product",
              extra: DisplayProductModel.fromApi(products[index]),
            ),
            onDelete: () => productsStore.delete(products[index].id),
          ),
        ),
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () => context.goNamed("create_product"),
      ),
    );
  }
}
