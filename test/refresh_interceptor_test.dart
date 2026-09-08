import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

import 'package:getx_starter_kit/app/core/network/interceptors/refresh_interceptor.dart';
import 'package:getx_starter_kit/app/core/helpers/auth.dart';
import 'package:getx_starter_kit/app/core/constants/api_endpoints.dart';

class NoopErrorHandler extends ErrorInterceptorHandler {
  @override
  void next(DioException err) {}
}

void main() {
  setUp(() {
    Auth.testClearSession = null;
  });

  test('clears session on 401 for non-refresh endpoint', () async {
    var cleared = false;
    Auth.testClearSession = () async {
      cleared = true;
    };

    final interceptor = RefreshInterceptor();

    final requestOptions = RequestOptions(path: '/api/resource');
    final response = Response(statusCode: 401, requestOptions: requestOptions);
    final err = DioException(requestOptions: requestOptions, response: response);

    try {
      await interceptor.onError(err, NoopErrorHandler());
    } catch (_) {}

    expect(cleared, isTrue);
  });

  test('does not clear session for refresh endpoint', () async {
    var cleared = false;
    Auth.testClearSession = () async {
      cleared = true;
    };

    final interceptor = RefreshInterceptor();

    final requestOptions = RequestOptions(path: ApiEndpoints.refresh);
    final response = Response(statusCode: 401, requestOptions: requestOptions);
    final err = DioException(requestOptions: requestOptions, response: response);

    try {
      await interceptor.onError(err, NoopErrorHandler());
    } catch (_) {}

    expect(cleared, isFalse);
  });
}
