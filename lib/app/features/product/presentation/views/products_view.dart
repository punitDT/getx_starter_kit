import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_starter_kit/app/core/providers/app_logger.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FakeStore Marketplace')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.products.isEmpty) {
          return const Center(child: Text('No products found'));
        }

        AppLogger.debug('UI Products: ${controller.products.length}');

        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final item = controller.products[index];
            return ListTile(
              leading: Image.network(
                item.image,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              title: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
            );
          },
        );
      }),
    );
  }
}
