import 'package:get/get.dart';
import 'package:getx_starter_kit/app/core/providers/user_provider.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    final auth = await UserProvider.isAuthenticated();
    if (auth) {
      Get.offAllNamed(AppRoutes.home);
      return;
    }
    Get.offAllNamed(AppRoutes.login);
  }
}
