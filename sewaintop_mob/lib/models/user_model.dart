import 'dart:convert';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String password; // only used for simulated auth
  final String role; // 'penyewa' | 'pemilik'
  final String avatarInitials;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.password = '',
    required this.role,
    required this.avatarInitials,
  });

  // ── JSON (API) ──────────────────────────────────────
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String? ?? '',
      password: json['password'] as String? ?? '',
      role: json['role'] as String? ?? 'penyewa',
      avatarInitials: json['avatarInitials'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'avatarInitials': avatarInitials,
    };
  }

  /// Serialize for SharedPreferences storage (no password).
  String toPrefsJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'avatarInitials': avatarInitials,
    });
  }

  factory User.fromPrefsJson(String source) {
    final json = jsonDecode(source) as Map<String, dynamic>;
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String? ?? '',
      role: json['role'] as String? ?? 'penyewa',
      avatarInitials: json['avatarInitials'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [id, email];
}
