import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_starter_kit/app/core/providers/app_logger.dart';

import '../../../../core/widgets/snackbar_helper.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

class ProductsController extends GetxController {
  ProductsController(this._repository);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxList<ProductEntity> products = <ProductEntity>[].obs;
  final ProductRepository _repository;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
  }

  /// Fetch all list of products
  Future<void> fetchAllProducts() async {
    try {
      AppLogger.info('Fetching all products');
      final List<ProductEntity> result = await _repository.fetchAllProducts();
      AppLogger.info('Result of fetchAllProducts');
      AppLogger.info(result);
      products(result);
      products.refresh();
      SnackbarHelper.showSuccess('Welcome ');
    } catch (e) {
      AppLogger.error('Error fetching products: $e');
      SnackbarHelper.showError('Error fetching products: $e');
    }
  }
}
