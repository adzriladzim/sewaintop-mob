import 'package:flutter/foundation.dart';
import 'package:sewaintop_mob/data/api_client.dart';
import 'package:sewaintop_mob/data/local_database.dart';
import 'package:sewaintop_mob/models/booking_model.dart';

/// Repository for booking operations with offline-first fallback.
class BookingRepository {
  final ApiClient _api = ApiClient();
  final LocalDatabase _db = LocalDatabase();

  /// Fetch bookings for a user. Returns (bookings, isFromCache).
  Future<({List<Booking> bookings, bool isFromCache})> fetchBookings(int userId) async {
    try {
      final response = await _api.get('/bookings', queryParams: {
        'userId': userId.toString(),
      });
      final bookings =
          (response as List).map((j) => Booking.fromJson(j as Map<String, dynamic>)).toList();
      debugPrint('[BookingRepo] Loaded ${bookings.length} bookings from API');

      // Cache for offline use
      await _db.cacheBookings(userId, bookings);

      return (bookings: bookings, isFromCache: false);
    } catch (e) {
      debugPrint('[BookingRepo] API failed ($e), falling back to cache');

      final cached = await _db.getCachedBookings(userId);
      return (bookings: cached, isFromCache: true);
    }
  }

  /// Create a new booking.
  Future<Booking> createBooking(Booking booking) async {
    try {
      final response = await _api.post('/bookings', body: booking.toJson());
      final created = Booking.fromJson(response as Map<String, dynamic>);

      // Also cache locally
      await _db.insertBooking(created);
      debugPrint('[BookingRepo] Booking created: ${created.id}');

      return created;
    } catch (e) {
      debugPrint('[BookingRepo] createBooking failed: $e');
      throw Exception('Gagal membuat booking. Periksa koneksi internet Anda.');
    }
  }

  /// Cancel a booking (set status to 'cancelled').
  Future<void> cancelBooking(int bookingId) async {
    try {
      await _api.patch('/bookings/$bookingId', body: {
        'status': 'cancelled',
      });
      debugPrint('[BookingRepo] Booking $bookingId cancelled');
    } catch (e) {
      debugPrint('[BookingRepo] cancelBooking failed: $e');
      throw Exception('Gagal membatalkan booking. Periksa koneksi internet Anda.');
    }
  }
}
