import 'package:diet_tracker/resources/models/base.dart';
import 'package:dio/dio.dart';

class ModelToJsonInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data is DisplayModel) {
      options.data = (options.data as DisplayModel).toMap();
    }
    super.onRequest(options, handler);
  }
}
