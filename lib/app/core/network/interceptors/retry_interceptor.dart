import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  int _maxRetries = 3;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
      if (_maxRetries > 0) {
        _maxRetries--;
        await Future<void>.delayed(const Duration(seconds: 1));
        handler.resolve(await _retryRequest(err.requestOptions));
        return;
      }
    }
    handler.next(err);
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final client = Dio();
    return client.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
        contentType: requestOptions.contentType,
      ),
    );
  }
}
