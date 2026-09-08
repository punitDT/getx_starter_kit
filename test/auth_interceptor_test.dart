import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

import 'package:getx_starter_kit/app/core/network/interceptors/auth_interceptor.dart';
import 'package:getx_starter_kit/app/core/helpers/auth.dart';

void main() {
  setUp(() {
    Auth.testAccessToken = null;
  });

  test('adds authorization header when token present', () async {
    Auth.testAccessToken = () async => 'abc123';
    final interceptor = AuthInterceptor();
    final options = RequestOptions(path: '/api/test', headers: {});

    // Handler not needed for header mutation test
    interceptor.onRequest(options, RequestInterceptorHandler());
    // allow async onRequest body to run
    await Future<void>.delayed(Duration.zero);

    expect(options.headers['Authorization'], 'Bearer abc123');
  });

  test('does not add header for public endpoints', () async {
    Auth.testAccessToken = () async => 'abc123';
    final interceptor = AuthInterceptor();
    final options = RequestOptions(path: '/auth/login', headers: {});

    interceptor.onRequest(options, RequestInterceptorHandler());

    expect(options.headers.containsKey('Authorization'), isFalse);
  });
}
