import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/resources/api/products.dart';
import 'package:mobx/mobx.dart';

part 'products.g.dart';

class ProductsStore extends _ProductsStore with _$ProductsStore {
  ProductsStore() {
    load();
  }
}

abstract class _ProductsStore with Store {
  final _productsApi = ProductsApi();

  @observable
  var products = ObservableList<ProductModel>();

  @action
  Future<void> load() async {
    final fetchedProducts = await _productsApi.getProducts();
    if (fetchedProducts != null) {
      products.addAll(fetchedProducts);
    }
  }

  @action
  Future<void> create(ProductModel product) async {
    try {
      final createdProduct = await _productsApi.createProduct(product);
      if (createdProduct != null) {
        products.add(createdProduct);
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> update(ProductModel product) async {
    try {
      final updatedProduct = await _productsApi.createProduct(product);
      if (updatedProduct != null) {
        final foundIndex =
            products.indexWhere((product) => product.id == updatedProduct.id);
        if (foundIndex > -1) {
          products.insert(foundIndex, updatedProduct);
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
