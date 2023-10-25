import 'package:diet_tracker/dio_client.dart';
import 'package:diet_tracker/resources/models.dart';

class ProductsApi {
  final dioClient = DioClient().dio;
  Future<List<ProductModel>?> getProducts() async {
    final response = await dioClient.get("products");
    if (response.data != null) {
      return (response.data as Iterable)
          .map((e) => ProductModel.fromMap(e))
          .toList();
    }
    return null;
  }

  Future<ProductModel?> createProduct(ProductModel product) async {
    final response = await dioClient.post("products", data: product);
    if (response.data is Map) {
      return ProductModel.fromMap(response.data);
    }
    return null;
  }

  Future<ProductModel?> updateProduct(ProductModel product) async {
    final response =
        await dioClient.patch("products/${product.id}", data: product);
    if (response.data) {
      return ProductModel.fromMap(response.data);
    }
    return null;
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      await dioClient.delete("products/$productId");
      return true;
    } catch (e) {
      return false;
    }
  }
}
