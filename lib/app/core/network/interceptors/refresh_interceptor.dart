import 'package:dio/dio.dart';

import '../../constants/api_endpoints.dart';
import 'package:getx_starter_kit/app/core/helpers/auth.dart';

class RefreshInterceptor extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final shouldRefresh = err.requestOptions.path != ApiEndpoints.refresh;
      if (shouldRefresh) {
        await Auth.clearSession();
      }
    }
    handler.next(err);
  }
}
