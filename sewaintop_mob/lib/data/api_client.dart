import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:sewaintop_mob/constants/app_config.dart';

/// Centralized HTTP client wrapper for json-server API calls.
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  String get _baseUrl {
    // On web or desktop, use localhost; on Android emulator use 10.0.2.2
    if (kIsWeb) return AppConfig.apiBaseUrlDesktop;
    try {
      if (Platform.isAndroid) return AppConfig.apiBaseUrl;
    } catch (_) {}
    return AppConfig.apiBaseUrlDesktop;
  }

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  /// Generic GET request
  Future<dynamic> get(String endpoint, {Map<String, String>? queryParams}) async {
    final uri = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: queryParams);
    debugPrint('[API] GET $uri');

    final response = await http
        .get(uri, headers: _headers)
        .timeout(AppConfig.apiTimeout);

    return _handleResponse(response);
  }

  /// Generic POST request
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    debugPrint('[API] POST $uri');

    final response = await http
        .post(uri, headers: _headers, body: jsonEncode(body))
        .timeout(AppConfig.apiTimeout);

    return _handleResponse(response);
  }

  /// Generic PATCH request
  Future<dynamic> patch(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    debugPrint('[API] PATCH $uri');

    final response = await http
        .patch(uri, headers: _headers, body: jsonEncode(body))
        .timeout(AppConfig.apiTimeout);

    return _handleResponse(response);
  }

  /// Generic DELETE request
  Future<dynamic> delete(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    debugPrint('[API] DELETE $uri');

    final response = await http
        .delete(uri, headers: _headers)
        .timeout(AppConfig.apiTimeout);

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'API Error: ${response.statusCode} — ${response.body}',
      );
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException($statusCode): $message';
}
