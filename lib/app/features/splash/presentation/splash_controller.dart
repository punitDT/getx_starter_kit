import 'package:get/get.dart';

import '../../../core/services/secure_storage_service.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final SecureStorageService _secureStorageService = const SecureStorageService();

  @override
  void onReady() {
    super.onReady();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    final accessToken = await _secureStorageService.getAccessToken();
    final isExpired = await _secureStorageService.isTokenExpired();
    if (accessToken != null && !isExpired) {
      Get.offAllNamed(AppRoutes.home);
      return;
    }
    Get.offAllNamed(AppRoutes.login);
  }
}
