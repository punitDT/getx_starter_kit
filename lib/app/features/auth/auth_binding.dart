import 'package:get/get.dart';

import 'data/data_sources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'presentation/controllers/auth_controller.dart';

import '../../core/network/api_client.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    final apiClient = Get.find<ApiClient>();
    Get.lazyPut(() => AuthRemoteDataSource(apiClient), fenix: true);
    Get.lazyPut(() => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()), fenix: true);
    Get.lazyPut(() => AuthController(Get.find<AuthRepositoryImpl>()), fenix: true);
  }
}
