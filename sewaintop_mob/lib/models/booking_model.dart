import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final int id;
  final int userId;
  final int laptopId;
  final String laptopTitle;
  final String laptopImage;
  final String startDate; // ISO 8601 date string
  final String endDate;
  final int duration;
  final double pricePerDay;
  final double totalPrice;
  final String status; // 'active' | 'completed' | 'cancelled'
  final String notes;
  final String shopName;
  final String createdAt;

  const Booking({
    required this.id,
    required this.userId,
    required this.laptopId,
    required this.laptopTitle,
    required this.laptopImage,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.pricePerDay,
    required this.totalPrice,
    required this.status,
    this.notes = '',
    required this.shopName,
    required this.createdAt,
  });

  // ── JSON (API) ──────────────────────────────────────
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int,
      userId: json['userId'] as int,
      laptopId: json['laptopId'] as int,
      laptopTitle: json['laptopTitle'] as String,
      laptopImage: json['laptopImage'] as String? ?? '',
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      duration: json['duration'] as int,
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'] as String,
      notes: json['notes'] as String? ?? '',
      shopName: json['shopName'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'laptopId': laptopId,
      'laptopTitle': laptopTitle,
      'laptopImage': laptopImage,
      'startDate': startDate,
      'endDate': endDate,
      'duration': duration,
      'pricePerDay': pricePerDay,
      'totalPrice': totalPrice,
      'status': status,
      'notes': notes,
      'shopName': shopName,
      'createdAt': createdAt,
    };
  }

  // ── sqflite (DB) ────────────────────────────────────
  factory Booking.fromDb(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] as int,
      userId: map['userId'] as int,
      laptopId: map['laptopId'] as int,
      laptopTitle: map['laptopTitle'] as String,
      laptopImage: map['laptopImage'] as String? ?? '',
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      duration: map['duration'] as int,
      pricePerDay: map['pricePerDay'] as double,
      totalPrice: map['totalPrice'] as double,
      status: map['status'] as String,
      notes: map['notes'] as String? ?? '',
      shopName: map['shopName'] as String? ?? '',
      createdAt: map['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'userId': userId,
      'laptopId': laptopId,
      'laptopTitle': laptopTitle,
      'laptopImage': laptopImage,
      'startDate': startDate,
      'endDate': endDate,
      'duration': duration,
      'pricePerDay': pricePerDay,
      'totalPrice': totalPrice,
      'status': status,
      'notes': notes,
      'shopName': shopName,
      'createdAt': createdAt,
    };
  }

  @override
  List<Object?> get props => [id, userId, laptopId, startDate];
}
