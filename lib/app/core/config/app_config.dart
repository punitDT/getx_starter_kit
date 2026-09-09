/// Compile-time environment configuration.
///
/// Values are injected at build time via --dart-define-from-file.
/// Access anywhere in the app via AppConfig.baseUrl etc.
/// Never use String.fromEnvironment() directly outside this file.
class AppConfig {
  AppConfig._();

  static const String environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'development',
  );

  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'GetX Starter Kit',
  );

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://dev-api.yourapp.com/v1',
  );

  static const int connectTimeout = int.fromEnvironment(
    'API_CONNECT_TIMEOUT',
    defaultValue: 15,
  );

  static const int receiveTimeout = int.fromEnvironment(
    'API_RECEIVE_TIMEOUT',
    defaultValue: 30,
  );

  static const bool enableLogging = bool.fromEnvironment(
    'ENABLE_LOGGING',
    defaultValue: true,
  );

  // ── Derived helpers ───────────────────────────────────────

  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';
}