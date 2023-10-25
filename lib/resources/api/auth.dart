import 'package:diet_tracker/dio_client.dart';

class AuthApi {
  final dioClient = DioClient().dio;
  Future<bool> loggedInCheck() async {
    try {
      await dioClient.get("auth/healthz");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(
    String username,
    String password,
    String name,
    String phonenumber,
  ) async {
    try {
      await dioClient.post(
        "auth/register",
        data: {
          "username": username,
          "password": password,
          "name": name,
          "phonenumber": phonenumber,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      await dioClient.post(
        "auth/login",
        data: {
          "username": username,
          "password": password,
        },
      );
      return true;
    } catch (e) {
      return false;
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
