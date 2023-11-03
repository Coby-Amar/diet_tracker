import 'package:diet_tracker/resources/models/create.dart';
import 'package:dio/dio.dart';

class ModelToJsonInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data is CreationModel) {
      options.data = (options.data as CreationModel).toMap();
    }
    super.onRequest(options, handler);
  }
}
