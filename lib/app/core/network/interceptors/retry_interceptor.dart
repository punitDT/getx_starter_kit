import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      const maxRetries = 3;
      if (maxRetries > 0) {
        for (var i = 0; i < maxRetries; i++) {
          await Future<void>.delayed(const Duration(seconds: 1));
          try {
            final Response<dynamic> response = await Dio().request(
              err.requestOptions.path,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
              options: Options(
                method: err.requestOptions.method,
                headers: err.requestOptions.headers,
                contentType: err.requestOptions.contentType,
              ),
            );
            handler.resolve(response);
            return;
          } catch (_) {
            if (i == maxRetries - 1) {
              handler.next(err);
            }
          }
        }
      } else {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }
}
