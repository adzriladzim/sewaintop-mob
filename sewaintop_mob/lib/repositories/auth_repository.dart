import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sewaintop_mob/constants/app_config.dart';
import 'package:sewaintop_mob/data/api_client.dart';
import 'package:sewaintop_mob/models/user_model.dart';

/// Repository for simulated authentication.
/// Uses json-server for user lookup and SharedPreferences for session persistence.
class AuthRepository {
  final ApiClient _api = ApiClient();

  /// Attempt login with email + password.
  /// Queries json-server: GET /users?email=...&password=...
  Future<User> login(String email, String password) async {
    try {
      final response = await _api.get('/users', queryParams: {
        'email': email,
        'password': password,
      });

      final users = response as List;
      if (users.isEmpty) {
        throw Exception('Email atau password salah');
      }

      final user = User.fromJson(users.first as Map<String, dynamic>);

      // Persist session
      await _saveSession(user);
      debugPrint('[AuthRepo] Login success: ${user.name}');

      return user;
    } catch (e) {
      if (e.toString().contains('Email atau password salah')) rethrow;
      throw Exception('Gagal login. Periksa koneksi internet Anda.');
    }
  }

  /// Register a new user.
  Future<User> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    try {
      // Check if email already exists
      final existing = await _api.get('/users', queryParams: {'email': email});
      if ((existing as List).isNotEmpty) {
        throw Exception('Email sudah terdaftar');
      }

      // Create initials from name
      final parts = name.trim().split(' ');
      final initials = parts.length >= 2
          ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
          : parts[0].substring(0, 2).toUpperCase();

      final response = await _api.post('/users', body: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'role': role,
        'avatarInitials': initials,
      });

      final user = User.fromJson(response as Map<String, dynamic>);

      // Persist session
      await _saveSession(user);
      debugPrint('[AuthRepo] Register success: ${user.name}');

      return user;
    } catch (e) {
      if (e.toString().contains('sudah terdaftar')) rethrow;
      throw Exception('Gagal mendaftar. Periksa koneksi internet Anda.');
    }
  }

  /// Get current logged-in user from SharedPreferences.
  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(AppConfig.prefKeyIsLoggedIn) ?? false;
    if (!isLoggedIn) return null;

    final userJson = prefs.getString(AppConfig.prefKeyUser);
    if (userJson == null) return null;

    try {
      return User.fromPrefsJson(userJson);
    } catch (e) {
      debugPrint('[AuthRepo] Failed to parse saved user: $e');
      return null;
    }
  }

  /// Logout — clear session.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConfig.prefKeyUser);
    await prefs.setBool(AppConfig.prefKeyIsLoggedIn, false);
    debugPrint('[AuthRepo] Logged out');
  }

  Future<void> _saveSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConfig.prefKeyUser, user.toPrefsJson());
    await prefs.setBool(AppConfig.prefKeyIsLoggedIn, true);
  }
}
