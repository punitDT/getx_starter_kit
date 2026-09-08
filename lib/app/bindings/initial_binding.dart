import 'package:get/get.dart';

import '../core/network/api_client.dart';
import '../core/services/app_info_service.dart';
import '../core/services/connectivity_service.dart';
import '../core/services/secure_storage_service.dart';
import '../core/services/storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageService(), permanent: true);
    Get.put(const SecureStorageService(), permanent: true);
    Get.put(ApiClient(), permanent: true);
    Get.put(ConnectivityService(), permanent: true);
    Get.put(AppInfoService(), permanent: true);
  }
}
