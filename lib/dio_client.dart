import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'package:diet_tracker/interceptors/auto_logout.dart';
import 'package:diet_tracker/interceptors/model_convert.dart';

class DioClient {
  Dio? _dio;
  static final DioClient _instance = DioClient._();
  factory DioClient() {
    return _instance;
  }

  DioClient._() {
    // _cookieJar.deleteAll();
    _prepareIntercepters();
  }

  Future<Dio> _getDio() async {
    if (_dio != null) {
      return Future.value(_dio);
    }
    return Future.delayed(
      const Duration(milliseconds: 200),
      _getDio,
    );
  }

  get(String path) async => (await _getDio()).get(path);

  post(String path, {Object? data}) async =>
      (await _getDio()).post(path, data: data);
  patch(String path, {Object? data}) async => (await _getDio()).patch(path);
  delete(String path) async => (await _getDio()).delete(path);

  Future<void> _prepareIntercepters() async {
    final dio = Dio(BaseOptions(
      baseUrl: "http://10.100.102.41:8080/api/v1/",
      contentType: 'application/json',
    ));
    dio.interceptors.add(AutoLogoutInterceptor());
    dio.interceptors.add(ModelToJsonInterceptor());
    if (kIsWeb) {
      return;
    }
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String cookiePath = "${appDocDir.path}/.cookies/";
    final cookieJar = PersistCookieJar(
      deleteHostCookiesWhenLoadFailed: true,
      storage: FileStorage(cookiePath),
    );
    dio.interceptors.add(CookieManager(cookieJar));
    _dio = dio;
  }
}
