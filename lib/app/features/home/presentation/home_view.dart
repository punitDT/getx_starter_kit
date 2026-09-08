import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/base/base_view.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import 'home_controller.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            final controller = Get.find<HomeController>();
            await Get.offAllNamed(AppRoutes.login);
            controller.hideLoading();
          },
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    final items = controller.menuItems;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.star, color: AppColors.primary),
              title: Text(item, style: AppTextStyles.titleMedium),
            ),
          );
        },
      ),
    );
  }
}
