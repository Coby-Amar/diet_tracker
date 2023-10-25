import 'package:cookie_jar/cookie_jar.dart';
import 'package:diet_tracker/main.dart';
import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/resources/stores/auth.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:provider/provider.dart';

class ModelToJsonInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data is Model) {
      options.data = (options.data as Model).toMap();
    }
    super.onRequest(options, handler);
  }
}

class AutoLogoutInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      DioClient().deleteAllCookies();
      final authStore =
          Provider.of<AuthStore>(navigatorKey.currentContext!, listen: false);
      if (authStore.loggedIn) {
        authStore.logout();
      }
      navigatorKey.currentState?.pushReplacementNamed("login");
    } else {
      super.onError(err, handler);
    }
  }
}

class DioClient {
  final _dio = Dio();
  final _cookieJar = PersistCookieJar();
  static final DioClient _instance = DioClient._();
  factory DioClient() {
    return _instance;
  }
  DioClient._() {
    // _cookieJar.deleteAll();
    _dio.options = BaseOptions(
      baseUrl: "http://localhost:8080/api/v1/",
      contentType: 'application/json',
    );
    _dio.interceptors.add(ModelToJsonInterceptor());
    _dio.interceptors.add(AutoLogoutInterceptor());
    _dio.interceptors.add(CookieManager(_cookieJar));
  }

  Dio get dio => _instance._dio;
  Future<void> deleteAllCookies() async {
    await _cookieJar.deleteAll();
  }
}
