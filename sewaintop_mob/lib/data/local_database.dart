import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:sewaintop_mob/constants/app_config.dart';
import 'package:sewaintop_mob/models/laptop_model.dart';
import 'package:sewaintop_mob/models/booking_model.dart';

/// Singleton sqflite database helper for offline caching.
class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
  LocalDatabase._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConfig.dbName);
    debugPrint('[DB] Opening database at $path');

    return openDatabase(
      path,
      version: AppConfig.dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    debugPrint('[DB] Creating tables...');

    await db.execute('''
      CREATE TABLE laptops (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        price TEXT NOT NULL,
        tags TEXT NOT NULL,
        rating REAL NOT NULL,
        reviews INTEGER NOT NULL,
        imageUrl TEXT NOT NULL,
        isAvailable INTEGER NOT NULL DEFAULT 1,
        category TEXT NOT NULL,
        ram TEXT NOT NULL,
        processor TEXT NOT NULL,
        priceNumeric REAL NOT NULL,
        cpu TEXT,
        storage TEXT,
        gpu TEXT,
        display TEXT,
        os TEXT,
        priceWeek TEXT,
        priceMonth TEXT,
        shopName TEXT,
        shopArea TEXT,
        imageUrls TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE bookings (
        id INTEGER PRIMARY KEY,
        userId INTEGER NOT NULL,
        laptopId INTEGER NOT NULL,
        laptopTitle TEXT NOT NULL,
        laptopImage TEXT,
        startDate TEXT NOT NULL,
        endDate TEXT NOT NULL,
        duration INTEGER NOT NULL,
        pricePerDay REAL NOT NULL,
        totalPrice REAL NOT NULL,
        status TEXT NOT NULL DEFAULT 'active',
        notes TEXT,
        shopName TEXT,
        createdAt TEXT
      )
    ''');

    debugPrint('[DB] Tables created successfully');
  }

  // ── Laptops ───────────────────────────────────────────

  /// Cache a list of laptops (replaces old cache).
  Future<void> cacheLaptops(List<Laptop> laptops) async {
    final db = await database;
    final batch = db.batch();
    batch.delete('laptops'); // clear old cache
    for (final laptop in laptops) {
      batch.insert('laptops', laptop.toDb(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
    debugPrint('[DB] Cached ${laptops.length} laptops');
  }

  /// Get all cached laptops.
  Future<List<Laptop>> getCachedLaptops() async {
    final db = await database;
    final maps = await db.query('laptops');
    debugPrint('[DB] Loaded ${maps.length} cached laptops');
    return maps.map((m) => Laptop.fromDb(m)).toList();
  }

  // ── Bookings ──────────────────────────────────────────

  /// Cache a list of bookings (replaces old cache for given userId).
  Future<void> cacheBookings(int userId, List<Booking> bookings) async {
    final db = await database;
    final batch = db.batch();
    batch.delete('bookings', where: 'userId = ?', whereArgs: [userId]);
    for (final booking in bookings) {
      batch.insert('bookings', booking.toDb(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
    debugPrint('[DB] Cached ${bookings.length} bookings for user $userId');
  }

  /// Insert a single booking into cache.
  Future<void> insertBooking(Booking booking) async {
    final db = await database;
    await db.insert('bookings', booking.toDb(), conflictAlgorithm: ConflictAlgorithm.replace);
    debugPrint('[DB] Inserted booking ${booking.id}');
  }

  /// Get cached bookings for a user.
  Future<List<Booking>> getCachedBookings(int userId) async {
    final db = await database;
    final maps = await db.query('bookings', where: 'userId = ?', whereArgs: [userId]);
    debugPrint('[DB] Loaded ${maps.length} cached bookings for user $userId');
    return maps.map((m) => Booking.fromDb(m)).toList();
  }

  // ── Utilities ─────────────────────────────────────────

  /// Clear all cached data.
  Future<void> clearAll() async {
    final db = await database;
    await db.delete('laptops');
    await db.delete('bookings');
    debugPrint('[DB] All caches cleared');
  }
}
