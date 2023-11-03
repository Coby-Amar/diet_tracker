import 'package:diet_tracker/dio_client.dart';
import 'package:diet_tracker/resources/models/create.dart';
import 'package:diet_tracker/resources/models/api.dart';

class ProductsApi {
  final dioClient = DioClient();
  Future<List<ApiProduct>?> getProducts() async {
    final response = await dioClient.get("products");
    if (response.data != null) {
      return (response.data as Iterable)
          .map((e) => ApiProduct.fromMap(e))
          .toList();
    }
    return null;
  }

  Future<ApiProduct?> createProduct(CreateProduct product) async {
    final response = await dioClient.post("products", data: product);
    if (response.data is Map) {
      return ApiProduct.fromMap(response.data);
    }
    return null;
  }

  Future<ApiProduct?> updateProduct(
    ApiProduct product,
  ) async {
    final response =
        await dioClient.patch("products/${product.id}", data: product);
    if (response.data) {
      return ApiProduct.fromMap(response.data);
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
