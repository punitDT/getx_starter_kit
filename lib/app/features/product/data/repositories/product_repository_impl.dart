import 'dart:async';

import 'package:dio/dio.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_source/product_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  // Inject the ProductDataSource dependency
  ProductDataSource _productDataSource;

  ProductRepositoryImpl(this._productDataSource);

  @override
  Future<List<ProductEntity>> fetchAllProducts() async {
    try {
      final Response response = await _productDataSource.fetchProducts();

      if (response.statusCode != 200) {
        throw Exception('Network Error: ${response.statusMessage}');
      }
      final List<dynamic> body = response.data;

      return body
          .map<ProductEntity>((item) => ProductModel.fromJson(item))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unknown Error: $e');
    }
  }
}
