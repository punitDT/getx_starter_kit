import 'package:dio/dio.dart';

import '../../services/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService = const SecureStorageService();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_isPublicEndpoint(options.path)) {
      handler.next(options);
      return;
    }

    final token = await _secureStorageService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  bool _isPublicEndpoint(String path) {
    return path.contains('/auth/login') || path.contains('/auth/register') || path.contains('/auth/refresh');
  }
}
