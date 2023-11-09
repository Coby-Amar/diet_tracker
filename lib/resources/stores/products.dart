import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:mobx/mobx.dart';

import 'package:diet_tracker/resources/api/products.dart';

part 'products.g.dart';

class ProductsStore extends _ProductsStore with _$ProductsStore {
  ProductsStore() {
    load();
  }
}

abstract class _ProductsStore with Store {
  final _productsApi = ProductsApi();

  @observable
  var products = ObservableList<ApiProduct>();

  @action
  Future<void> load() async {
    try {
      final fetchedProducts = await _productsApi.getProducts();
      if (fetchedProducts != null) {
        products.addAll(fetchedProducts);
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> create(DisplayProductModel productModel) async {
    try {
      final createdProduct = await _productsApi.createProduct(productModel);
      if (createdProduct != null) {
        products.add(createdProduct);
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> update(DisplayProductModel product) async {
    try {
      final updatedProduct = await _productsApi.updateProduct(product);
      if (updatedProduct != null) {
        final foundIndex =
            products.indexWhere((product) => product.id == updatedProduct.id);
        if (foundIndex > -1) {
          products.replaceRange(
            foundIndex,
            foundIndex + 1,
            [updatedProduct],
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> delete(String productId) async {
    try {
      await _productsApi.deleteProduct(productId);
      products.removeWhere((element) => element.id == productId);
    } catch (e) {
      print(e);
    }
  }
}
