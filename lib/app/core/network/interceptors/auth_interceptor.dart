import 'package:dio/dio.dart';

import 'package:getx_starter_kit/app/core/helpers/auth.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_isPublicEndpoint(options.path)) {
      handler.next(options);
      return;
    }

    final token = await Auth.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  bool _isPublicEndpoint(String path) {
    return path.contains('/auth/login') || path.contains('/auth/register') || path.contains('/auth/refresh');
  }
}
