import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:getx_starter_kit/app/core/config/app_config.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/refresh_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

class ApiClient extends GetxService {
  @override
  void onInit() {
    super.onInit();

    const baseUrl = AppConfig.baseUrl;
    const timeoutSeconds = AppConfig.connectTimeout;
    const connectTimeoutSeconds = AppConfig.receiveTimeout;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: connectTimeoutSeconds),
        receiveTimeout: const Duration(seconds: timeoutSeconds),
        sendTimeout: const Duration(seconds: timeoutSeconds),
        contentType: 'application/json',
        headers: {'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.addAll([
      LoggingInterceptor(),
      AuthInterceptor(),
      RetryInterceptor(),
      RefreshInterceptor(),
    ]);
  }


  late final Dio _dio;

  Dio get dio => _dio;

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.get<T>(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(String path, {dynamic data, Options? options, Map<String, dynamic>? queryParameters}) {
    return _dio.post<T>(path, data: data, options: options, queryParameters: queryParameters);
  }

  Future<Response<T>> put<T>(String path, {dynamic data, Options? options}) {
    return _dio.put<T>(path, data: data, options: options);
  }

  Future<Response<T>> delete<T>(String path, {dynamic data, Options? options}) {
    return _dio.delete<T>(path, data: data, options: options);
  }

  Future<Response<T>> patch<T>(String path, {dynamic data, Options? options}) {
    return _dio.patch<T>(path, data: data, options: options);
  }

  Future<Response<T>> upload<T>(String path, {required FormData data}) {
    return _dio.post<T>(path, data: data);
  }
}
