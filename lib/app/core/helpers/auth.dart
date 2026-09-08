import 'package:get/get.dart';

import '../services/user_session.dart';
import '../services/secure_storage_service.dart';
import '../../features/auth/domain/entities/user_entity.dart';

/// Simple, globally-available helper so code can use `Auth.user` / `Auth.isLoggedIn`
/// without calling `Get.find<UserSession>()` everywhere.
///
/// Includes hooks to override behavior in tests via the `test*` static fields.
class Auth {
  Auth._();

  // Testing overrides (set in tests)
  static Future<bool> Function()? testIsAuthenticated;
  static Future<String?> Function()? testAccessToken;
  static Future<void> Function()? testClearSession;

  static UserSession get session => Get.find<UserSession>();

  /// Current cached user (sync)
  static UserEntity? get user => session.user;

  /// True if a user object exists (doesn't check token expiry)
  static bool get isLoggedIn => session.hasUser;

  /// Checks token expiry and returns whether the session is still authenticated
  static Future<bool> isAuthenticated() =>
      testIsAuthenticated != null ? testIsAuthenticated!() : session.isAuthenticated();

  /// Access token (nullable)
  static Future<String?> get accessToken =>
      testAccessToken != null ? testAccessToken!() : session.getAccessToken();

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
    if (testClearSession != null) return testClearSession!();
    await session.clearUser();
    await const SecureStorageService().clearAll();
  }
}
