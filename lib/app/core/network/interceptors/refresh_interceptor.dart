import 'package:dio/dio.dart';

import '../../constants/api_endpoints.dart';
import '../../providers/user_provider.dart';

class RefreshInterceptor extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final shouldRefresh = err.requestOptions.path != ApiEndpoints.refresh;
      if (shouldRefresh) {
        await UserProvider.clearSession();
      }
    }
    handler.next(err);
  }
}
