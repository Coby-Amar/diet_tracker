import 'package:diet_tracker/dio_client.dart';
import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/models/display.dart';

class AuthApi {
  final dioClient = DioClient();

  Future<ApiUser?> user() async {
    final response = await dioClient.get("user");
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return ApiUser.fromMap(data);
    }
    return null;
  }

  Future<ApiUser?> register(Registration model) async {
    final response = await dioClient.post("auth/register", data: model);
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return ApiUser.fromMap(data);
    }
    return null;
  }

  Future<ApiUser?> login(Login loginModel) async {
    final response = await dioClient.post(
      "auth/login",
      data: loginModel,
    );
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return ApiUser.fromMap(data);
    }
    return null;
  }

  Future<void> logout() async => dioClient.post("auth/logout");
}
