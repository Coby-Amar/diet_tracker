import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:diet_tracker/app.dart';
import 'package:diet_tracker/resources/models/create.dart';
import 'package:diet_tracker/resources/stores/info.dart';

class ModelToJsonInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data is CreationModel) {
      options.data = (options.data as CreationModel).toMap();
    }
    super.onRequest(options, handler);
  }
}

class AutoLogoutInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      final authStore =
          Provider.of<InfoStore>(navigatorKey.currentContext!, listen: false);
      if (authStore.loggedIn) {
        authStore.logout();
      }
      navigatorKey.currentState?.pushReplacementNamed("login");
      return;
    }
    super.onError(err, handler);
  }
}

class DioClient {
  final _dio = Dio();
  late PersistCookieJar _cookieJar;
  static final DioClient _instance = DioClient._();
  factory DioClient() {
    return _instance;
  }
  DioClient._() {
    // _cookieJar.deleteAll();
    _dio.options = BaseOptions(
      baseUrl: "http://10.100.102.41:8080/api/v1/",
      contentType: 'application/json',
    );
    _dio.interceptors.add(ModelToJsonInterceptor());
    _dio.interceptors.add(AutoLogoutInterceptor());
    _prepareJar();
  }

  Dio get dio => _instance._dio;
  Future<void> deleteAllCookies() async {
    await _cookieJar.deleteAll();
  }

  Future<void> _prepareJar() async {
    if (kIsWeb) {
      return;
    }
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String cookiePath = "${appDocDir.path}/.cookies/";
    _cookieJar = PersistCookieJar(
      deleteHostCookiesWhenLoadFailed: true,
      storage: FileStorage(cookiePath),
    );
    _dio.interceptors.add(CookieManager(_cookieJar));
  }
}
