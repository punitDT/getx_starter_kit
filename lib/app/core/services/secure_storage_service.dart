import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/storage_keys.dart';

class SecureStorageService {
  const SecureStorageService();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveTokens({
    required String access,
    required String refresh,
    required DateTime expiry,
  }) async {
    await _storage.write(key: StorageKeys.accessToken, value: access);
    await _storage.write(key: StorageKeys.refreshToken, value: refresh);
    await _storage.write(key: StorageKeys.tokenExpiry, value: expiry.toIso8601String());
  }

  Future<String?> getAccessToken() async => _storage.read(key: StorageKeys.accessToken);

  Future<String?> getRefreshToken() async => _storage.read(key: StorageKeys.refreshToken);

  Future<bool> isTokenExpired() async {
    final expiryString = await _storage.read(key: StorageKeys.tokenExpiry);
    if (expiryString == null || expiryString.isEmpty) {
      return true;
    }
    final expiry = DateTime.tryParse(expiryString);
    if (expiry == null) {
      return true;
    }
    return DateTime.now().isAfter(expiry);
  }

  Future<void> clearAll() async => _storage.deleteAll();
}
