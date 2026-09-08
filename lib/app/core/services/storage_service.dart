import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/storage_keys.dart';
import '../../features/auth/domain/entities/user_entity.dart';

class StorageService extends GetxService {
  final GetStorage _box = GetStorage();

  T? read<T>(String key) => _box.read(key);

  void write(String key, dynamic value) => _box.write(key, value);

  void remove(String key) => _box.remove(key);

  Future<void> clear() async => _box.erase();

  // User persistence helpers
  Future<void> saveUser(UserEntity user) async {
    _box.write(StorageKeys.userProfileCache, user.toJson());
  }

  UserEntity? getUser() {
    final data = _box.read(StorageKeys.userProfileCache);
    if (data == null) return null;
    // Ensure it's a Map<String, dynamic>
    final map = Map<String, dynamic>.from(data as Map);
    return UserEntity.fromJson(map);
  }

  Future<void> clearUser() async {
    _box.remove(StorageKeys.userProfileCache);
  }
}
