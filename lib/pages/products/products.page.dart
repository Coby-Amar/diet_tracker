import 'package:diet_tracker/dialogs/are_you_sure.dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/widgets/product_item.dart';
import 'package:diet_tracker/widgets/floating_add_button.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.read<AppProvider>();
    final products = context.watch<AppProvider>().searchProductsFiltered;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: appProvider.loadProducts,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                hintText: 'Search by name',
                keyboardType: TextInputType.name,
                leading: const Icon(Icons.search),
                shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
                elevation: const WidgetStatePropertyAll(10),
                onChanged: (value) => appProvider.searchProductsQuery = value,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) => ProductItem(
                      product: products[index],
                      onEdit: () => context.pushNamed(
                            "update_product",
                            extra: products[index],
                          ),
                      onDelete: () async {
                        final response = await showDialog(
                          context: context,
                          builder: (context) => const AreYouSureDialog(
                            content: 'מוצר זה יאבד לנצח',
                          ),
                        );
                        if (response != null && response) {
                          appProvider.deleteProduct(products[index].id);
                        }
                      }),
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
