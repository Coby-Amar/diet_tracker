import 'package:diet_tracker/dio_client.dart';
import 'package:diet_tracker/resources/models/create.dart';
import 'package:diet_tracker/resources/models/api.dart';

class AuthApi {
  final dioClient = DioClient().dio;

  Future<ApiUser?> user() async {
    try {
      final response = await dioClient.get("user");
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return ApiUser.fromMap(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<ApiUser?> register(CreateRegistration model) async {
    try {
      final response = await dioClient.post("auth/register", data: model);
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return ApiUser.fromMap(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<ApiUser?> login(CreateLogin loginModel) async {
    try {
      final response = await dioClient.post(
        "auth/login",
        data: loginModel,
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return ApiUser.fromMap(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      await dioClient.post("auth/logout");
      return true;
    } catch (e) {
      return false;
    }
  }
}
