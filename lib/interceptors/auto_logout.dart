import 'package:diet_tracker/app.dart';
import 'package:diet_tracker/resources/stores/info.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class AutoLogoutInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      final authStore = Provider.of<InfoStore>(
          rootNavigationKey.currentContext!,
          listen: false);
      if (authStore.isLoggedIn) {
        authStore.logout();
      }
      rootNavigationKey.currentState?.pushReplacementNamed("login");
      return;
    }
    super.onError(err, handler);
  }
}
