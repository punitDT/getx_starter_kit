import 'package:dio/dio.dart';

import '../../providers/user_provider.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  static const _publicEndpoints = [
    '/auth/login',
    '/auth/register',
    '/auth/refresh',
  ];

  bool _isPublicEndpoint(String path) {
    return _publicEndpoints.any((endpoint) => path == endpoint || path.startsWith(endpoint + '/') || path == endpoint);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_isPublicEndpoint(options.path)) {
      handler.next(options);
      return;
    }

    final token = await UserProvider.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
