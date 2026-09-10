import 'package:dio/dio.dart';

import '../../constants/api_endpoints.dart';
import '../../providers/user_provider.dart';

class RefreshInterceptor extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final isRefreshPath = err.requestOptions.path == ApiEndpoints.refresh;
      if (!isRefreshPath) {
        final refreshToken = await UserProvider.refreshToken;
        if (refreshToken != null &&
            refreshToken.isNotEmpty &&
            refreshToken != 'Refresh token is missing.') {
          try {
            final response = await Dio().post(
              ApiEndpoints.refresh,
              data: {'refreshToken': refreshToken},
              options: Options(headers: {'Content-Type': 'application/json'}),
            );
            if (response.statusCode == 200 && response.data != null) {
              final accessToken = response.data['accessToken'] ?? '';
              handler.resolve(
                await Dio().request(
                  err.requestOptions.path,
                  data: err.requestOptions.data,
                  queryParameters: err.requestOptions.queryParameters,
                  options: Options(
                    method: err.requestOptions.method,
                    headers: {
                      ...err.requestOptions.headers,
                      'Authorization': 'Bearer $accessToken',
                    },
                  ),
                ),
              );
              return;
            }
          } catch (_) {
            // Token refresh failed
          }
        }
      }
    }
    await UserProvider.clearSession();
    handler.next(err);
  }
}