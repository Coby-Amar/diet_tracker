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
        onRefresh: () async {
          appProvider.searchProductsQuery = '';
          await appProvider.loadProducts();
        },
        child: Column(
          children: [
            PopScope(
              onPopInvokedWithResult: (didPop, result) =>
                  appProvider.searchProductsQuery = '',
              child: SearchBar(
                hintText: 'חפש לפי שם',
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
                      onEdit: () => context.goNamed(
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
        onPressed: () => context.goNamed("create_product"),
      ),
    );
  }
}
