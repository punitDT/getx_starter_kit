import 'package:get/get.dart';

import 'storage_service.dart';
import 'secure_storage_service.dart';
import '../../features/auth/domain/entities/user_entity.dart';

class UserSession extends GetxService {
  UserSession();

  final StorageService _storage = Get.find<StorageService>();
  final SecureStorageService _secure = Get.find<SecureStorageService>();

  final Rxn<UserEntity> currentUser = Rxn<UserEntity>();

  @override
  void onInit() {
    super.onInit();
    // load cached user synchronously (GetStorage returns sync data)
    final cached = _storage.getUser();
    if (cached != null) {
      currentUser.value = cached;
    }
  }

  bool get hasUser => currentUser.value != null;

  Future<bool> isAuthenticated() async {
    if (currentUser.value == null) return false;
    final expired = await _secure.isTokenExpired();
    return !expired;
  }

  UserEntity? get user => currentUser.value;

  Future<void> setUser(UserEntity u) async {
    currentUser.value = u;
    await _storage.saveUser(u);
  }

  Future<void> clearUser() async {
    currentUser.value = null;
    await _storage.clearUser();
  }

  Future<String?> getAccessToken() async => _secure.getAccessToken();

  Future<String?> getRefreshToken() async => _secure.getRefreshToken();
}
