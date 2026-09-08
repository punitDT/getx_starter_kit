import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response, FormData;

import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/refresh_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

class ApiClient extends GetxService {
  ApiClient() {
    final baseUrl = dotenv.env['BASE_URL'] ?? 'https://api.yourapp.com/v1';
    final timeoutSeconds = int.tryParse(dotenv.env['API_TIMEOUT_SECONDS'] ?? '30') ?? 30;
    final connectTimeoutSeconds = int.tryParse(dotenv.env['API_CONNECT_TIMEOUT_SECONDS'] ?? '15') ?? 15;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: connectTimeoutSeconds),
        receiveTimeout: Duration(seconds: timeoutSeconds),
        sendTimeout: Duration(seconds: timeoutSeconds),
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
