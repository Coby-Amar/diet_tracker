import 'package:diet_tracker/dio_client.dart';
import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/models/display.dart';

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

  Future<ApiProduct?> createProduct(DisplayProductModel product) async {
    final response = await dioClient.post("products", data: product);
    if (response.data is Map) {
      return ApiProduct.fromMap(response.data);
    }
    return null;
  }

  Future<ApiProduct?> updateProduct(DisplayProductModel product) async {
    final response = await dioClient.put("products", data: product);
    if (response.data is Map) {
      return ApiProduct.fromMap(response.data);
    }
    return null;
  }

  Future<void> deleteProduct(String productId) async =>
      dioClient.delete("products/$productId");
}
