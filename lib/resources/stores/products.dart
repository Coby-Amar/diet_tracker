import 'package:diet_tracker/resources/models/api.dart';
import 'package:mobx/mobx.dart';

import 'package:diet_tracker/resources/api/products.dart';
import 'package:diet_tracker/resources/models/create.dart';
import 'package:diet_tracker/resources/models/display.dart';

part 'products.g.dart';

class ProductsStore extends _ProductsStore with _$ProductsStore {
  ProductsStore() {
    load();
  }
}

abstract class _ProductsStore with Store {
  final _productsApi = ProductsApi();

  @observable
  var products = ObservableList<DisplayProduct>();

  @action
  Future<void> load() async {
    final fetchedProducts = await _productsApi.getProducts();
    if (fetchedProducts != null) {
      products.addAll(fetchedProducts.map((e) => DisplayProduct(e)));
    }
  }

  @action
  Future<void> create(CreateProduct productModel) async {
    try {
      final createdProduct = await _productsApi.createProduct(productModel);
      if (createdProduct != null) {
        products.add(DisplayProduct(createdProduct));
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> update(ApiProduct product) async {
    try {
      final updatedProduct = await _productsApi.updateProduct(product);
      if (updatedProduct != null) {
        final foundIndex =
            products.indexWhere((product) => product.id == updatedProduct.id);
        if (foundIndex > -1) {
          products.replaceRange(
            foundIndex,
            foundIndex + 1,
            [DisplayProduct(updatedProduct)],
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> delete(String productId) async {
    if (await _productsApi.deleteProduct(productId)) {
      products.removeWhere((element) => element.id == productId);
    }
  }
}
