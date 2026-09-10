import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';

class ProductDataSource {
  ProductDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<Response> fetchProducts() {
    return apiClient.get(ApiEndpoints.products);
  }
}
