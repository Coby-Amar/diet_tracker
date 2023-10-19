import 'package:diet_tracker/dio.dart';
import 'package:diet_tracker/providers/models.dart';

class APIProvider {
  static Future<void> healthCheck() async {
    await dioClient.get(
      "healthz",
    );
  }

  static Future<void> login(String username, String password) async {
    await dioClient.post(
      "auth/login",
      data: {"username": username, "password": password},
    );
  }

  static Future<void> logout() async {
    await dioClient.post("auth/logout");
  }

  static Future<void> getProducts() async {
    await dioClient.get("products");
  }

  static Future<void> updateProduct(ProductModel product) async {
    await dioClient.patch("products/${product.id}", data: product);
  }

  static Future<void> deleteProduct(String productId) async {
    await dioClient.delete("products/$productId");
  }

  static Future<void> getReports() async {
    await dioClient.get("reports");
  }

  static Future<void> deleteReport(String reportId) async {
    await dioClient.delete("reports/$reportId");
  }

  static Future<EntryModel> updateReportEntries(
      String reportId, EntryModel entry) async {
    final response =
        await dioClient.patch("reports/$reportId/${entry.id}", data: entry);
    return EntryModel.fromMap(response.data);
  }
}
