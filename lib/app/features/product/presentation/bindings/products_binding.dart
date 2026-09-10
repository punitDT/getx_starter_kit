import 'package:get/get.dart';

import '../../../../core/network/api_client.dart';
import '../../data/data_source/product_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    final apiClient = Get.find<ApiClient>();
    Get.lazyPut(() => ProductDataSource(apiClient), fenix: true);
    // Get.lazyPut(
    //   () => ProductRepositoryImpl(Get.find<ProductDataSource>()),
    //   fenix: true,
    // );
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(Get.find<ProductDataSource>()),
    );

    Get.lazyPut(
      () => ProductsController(Get.find<ProductRepository>()),
      fenix: true,
    );
  }
}
