import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/widgets/product_item.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:diet_tracker/widgets/floating_add_button.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.read<AppProvider>();
    final products = context.watch<AppProvider>().searchProductsFiltered;
    return Scaffold(
      appBar: const AppBarThemed(title: 'Products'),
      body: RefreshIndicator(
        onRefresh: appProvider.loadProducts,
        child: Column(
          children: [
            SearchBar(
              hintText: 'Search by name',
              keyboardType: TextInputType.name,
              leading: const Icon(Icons.search),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder()),
              elevation: const MaterialStatePropertyAll(10),
              onChanged: (value) => appProvider.searchProductsQuery = value,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: products.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ProductItem(
                  product: products[index],
                  onEdit: () => context.pushNamed(
                    "update_product",
                    extra: products[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () => context.pushNamed("create_product"),
      ),
    );
  }
}
