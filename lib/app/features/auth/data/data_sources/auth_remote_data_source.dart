import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/login_request_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<Response> login(LoginRequestModel request) {
    return apiClient.post(ApiEndpoints.login, data: request.toJson());
  }

  Future<Response> register(LoginRequestModel request) {
    return apiClient.post(ApiEndpoints.register, data: request.toJson());
  }
}
