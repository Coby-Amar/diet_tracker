import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:diet_tracker/main.dart';
import 'package:diet_tracker/providers/auth.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:provider/provider.dart';

final dio = Dio();
final cookieJar = CookieJar();

class AutoLogoutInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      cookieJar.deleteAll();
      final authProvider = Provider.of<AuthProvider>(
        navigatorKey.currentContext!,
        listen: false,
      );
      authProvider.logout(true);
    }
    super.onError(err, handler);
  }
}

Dio get dioClient {
  dio.options = BaseOptions(
    baseUrl: "http://localhost:8080/api/v1/",
    contentType: 'application/json',
  );
  dio.interceptors.add(AutoLogoutInterceptor());
  dio.interceptors.add(CookieManager(cookieJar));
  return dio;
}
