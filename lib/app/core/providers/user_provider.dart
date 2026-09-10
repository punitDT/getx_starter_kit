import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/user_session.dart';
import '../services/secure_storage_service.dart';
import '../../features/auth/domain/entities/user_entity.dart';

/// Simple, globally-available helper so code can use `Auth.user` / `Auth.isLoggedIn`
/// without calling `Get.find<UserSession>()` everywhere.
///
/// Includes hooks to override behavior in tests via the `test*` static fields.
class UserProvider {
  UserProvider._();

  static UserSession get session => Get.find<UserSession>();

  /// Current cached user (sync)
  static UserEntity? get user => session.user;

  /// Get currant locale
  static Locale get locale => Get.locale!;

  /// update locale
  static void updateLocale(Locale newLocale) => Get.updateLocale(newLocale);

  /// True if a user object exists (doesn't check token expiry)
  static bool get isLoggedIn => session.hasUser;

  /// Checks token expiry and returns whether the session is still authenticated
  static Future<bool> isAuthenticated() => session.isAuthenticated();

  /// Access token (nullable)
  static Future<String?> get accessToken => session.getAccessToken();

  /// Refresh token (nullable)
  static Future<String?> get refreshToken =>
      session.getRefreshToken();

  /// Stream to listen for user changes
  static Stream<UserEntity?> get onUserChanged => session.currentUser.stream;

  /// Convenience setters
  static Future<void> setUser(UserEntity u) => session.setUser(u);
  static Future<void> clearUser() => session.clearUser();

  /// Clear user + secure tokens
  static Future<void> clearSession() async {
    await session.clearUser();
    try {
      await Get.find<SecureStorageService>().clearAll();
    } catch (_) {
      // SecureStorageService may not be initialized in test environments
    }
  }
}
