import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final requestPath = '${options.baseUrl}${options.path}';
    logger.i(
        'REQUEST[${options.method}] => URL: ${options.uri}\nHeaders: ${options.headers}\nBody: ${options.data}');
    // super.onRequest(options, handler); // Proceed with the request
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(
        'RESPONSE[${response.statusCode}] => URL: ${response.requestOptions.uri}\nHeaders: ${response.headers}\nData: ${response.data}');
    // super.onResponse(response, handler); // Proceed with the response
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message = err.response?.data['message'] ?? err.message;
    logger.e(
        "⛔ Error Details: ${err.toString()}\nERROR[${err.response?.statusCode}] => URL: ${err.requestOptions.uri}\nError Message: $message");
    handler.next(err);
  }
}
