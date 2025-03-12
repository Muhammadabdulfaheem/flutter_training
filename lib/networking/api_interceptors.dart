import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // You can add any global headers or tokens here
    print("Request: ${options.uri}");
    options.headers["Authorization"] = "Bearer your_token";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("Response: ${response.requestOptions.uri}");
    print("Response Data: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("Error: ${err.message}");
    super.onError(err, handler);
  }
}
