import 'package:flutter/foundation.dart';
import 'package:sewaintop_mob/data/api_client.dart';
import 'package:sewaintop_mob/data/local_database.dart';
import 'package:sewaintop_mob/models/laptop_model.dart';

/// Repository that follows offline-first strategy:
/// 1. Try fetching from API
/// 2. On success → cache to sqflite → return data
/// 3. On failure → fallback to sqflite cache
class LaptopRepository {
  final ApiClient _api = ApiClient();
  final LocalDatabase _db = LocalDatabase();

  /// Fetch all laptops. Returns (laptops, isFromCache).
  Future<({List<Laptop> laptops, bool isFromCache})> fetchLaptops() async {
    try {
      final response = await _api.get('/laptops');
      final laptops =
          (response as List).map((j) => Laptop.fromJson(j as Map<String, dynamic>)).toList();
      debugPrint('[LaptopRepo] Loaded ${laptops.length} laptops from API');

      // Cache for offline use
      await _db.cacheLaptops(laptops);

      return (laptops: laptops, isFromCache: false);
    } catch (e) {
      debugPrint('[LaptopRepo] API failed ($e), falling back to cache');

      final cached = await _db.getCachedLaptops();
      if (cached.isNotEmpty) {
        return (laptops: cached, isFromCache: true);
      }

      // Nothing in cache either
      throw Exception('Tidak ada koneksi internet dan tidak ada data tersimpan.');
    }
  }

  /// Fetch a single laptop by ID.
  Future<Laptop?> fetchLaptopById(int id) async {
    try {
      final response = await _api.get('/laptops/$id');
      return Laptop.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      debugPrint('[LaptopRepo] fetchLaptopById failed: $e');
      // Try from cache
      final cached = await _db.getCachedLaptops();
      try {
        return cached.firstWhere((l) => l.id == id);
      } catch (_) {
        return null;
      }
    }
  }
}
