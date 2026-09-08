import 'package:dio/dio.dart';

import '../../constants/api_endpoints.dart';
import '../../services/secure_storage_service.dart';

class RefreshInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService = const SecureStorageService();

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final shouldRefresh = err.requestOptions.path != ApiEndpoints.refresh;
      if (shouldRefresh) {
        await _secureStorageService.clearAll();
      }
    }
    handler.next(err);
  }
}
