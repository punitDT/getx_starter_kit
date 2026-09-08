import 'package:get/get.dart';

import 'package:getx_starter_kit/app/core/helpers/auth.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    final auth = await Auth.isAuthenticated();
    if (auth) {
      Get.offAllNamed(AppRoutes.home);
      return;
    }
    Get.offAllNamed(AppRoutes.login);
  }
}
