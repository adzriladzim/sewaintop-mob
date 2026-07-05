/// App-wide configuration constants
class AppConfig {
  // ── API ────────────────────────────────────────────────
  // Android emulator → 10.0.2.2 maps to host localhost
  // iOS simulator / Desktop / Web → localhost
  static const String apiBaseUrl = 'http://10.0.2.2:3000';
  static const String apiBaseUrlDesktop = 'http://localhost:3000';
  static const Duration apiTimeout = Duration(seconds: 8);

  // ── Local Database ────────────────────────────────────
  static const String dbName = 'sewain_cache.db';
  static const int dbVersion = 1;

  // ── SharedPreferences Keys ────────────────────────────
  static const String prefKeyUser = 'current_user';
  static const String prefKeyIsLoggedIn = 'is_logged_in';
}
