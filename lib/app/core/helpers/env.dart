/// Env helper: read configuration from compile-time dart-define values.
///
/// This intentionally does NOT depend on dotenv anymore. Use the tools/
/// launcher to pass defines from JSON into --dart-define when running/building.
class Env {
  Env._();

  static String get(String key, {String? defaultValue}) {
    switch (key) {
      case 'APP_ENV':
        const appEnv = String.fromEnvironment('APP_ENV');
        if (appEnv.isNotEmpty) return appEnv;
        break;
      case 'APP_NAME':
        const appName = String.fromEnvironment('APP_NAME');
        if (appName.isNotEmpty) return appName;
        break;
      case 'BASE_URL':
        const baseUrl = String.fromEnvironment('BASE_URL');
        if (baseUrl.isNotEmpty) return baseUrl;
        break;
      case 'API_KEY':
        const apiKey = String.fromEnvironment('API_KEY');
        if (apiKey.isNotEmpty) return apiKey;
        break;
      case 'API_TIMEOUT_SECONDS':
        const apiTimeout = String.fromEnvironment('API_TIMEOUT_SECONDS');
        if (apiTimeout.isNotEmpty) return apiTimeout;
        break;
      case 'API_CONNECT_TIMEOUT_SECONDS':
        const connectTimeout = String.fromEnvironment('API_CONNECT_TIMEOUT_SECONDS');
        if (connectTimeout.isNotEmpty) return connectTimeout;
        break;
      case 'ENABLE_LOGGING':
        const enableLogging = String.fromEnvironment('ENABLE_LOGGING');
        if (enableLogging.isNotEmpty) return enableLogging;
        break;
    }

    return defaultValue ?? '';
  }

  static bool has(String key) {
    final val = get(key);
    return val.isNotEmpty;
  }
}
