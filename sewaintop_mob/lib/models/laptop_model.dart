import 'package:equatable/equatable.dart';

class Laptop extends Equatable {
  final int id;
  final String title;
  final String price;
  final List<String> tags;
  final double rating;
  final int reviews;
  final String imageUrl;
  final bool isAvailable;
  final String category;
  final String ram;
  final String processor;
  final double priceNumeric;

  // Additional detail fields
  final String cpu;
  final String storage;
  final String gpu;
  final String display;
  final String os;
  final String priceWeek;
  final String priceMonth;
  final String shopName;
  final String shopArea;
  final List<String> imageUrls; // For swipe gallery

  const Laptop({
    required this.id,
    required this.title,
    required this.price,
    required this.tags,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    this.isAvailable = true,
    required this.category,
    required this.ram,
    required this.processor,
    required this.priceNumeric,
    required this.cpu,
    required this.storage,
    required this.gpu,
    required this.display,
    required this.os,
    required this.priceWeek,
    required this.priceMonth,
    required this.shopName,
    required this.shopArea,
    required this.imageUrls,
  });

  // ── JSON (API) ──────────────────────────────────────
  factory Laptop.fromJson(Map<String, dynamic> json) {
    return Laptop(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String,
      price: json['price'] as String,
      tags: List<String>.from(json['tags'] ?? []),
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'] as int,
      imageUrl: json['imageUrl'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
      category: json['category'] as String,
      ram: json['ram'] as String,
      processor: json['processor'] as String,
      priceNumeric: (json['priceNumeric'] as num).toDouble(),
      cpu: json['cpu'] as String? ?? '',
      storage: json['storage'] as String? ?? '',
      gpu: json['gpu'] as String? ?? '',
      display: json['display'] as String? ?? '',
      os: json['os'] as String? ?? '',
      priceWeek: json['priceWeek'] as String? ?? '',
      priceMonth: json['priceMonth'] as String? ?? '',
      shopName: json['shopName'] as String? ?? '',
      shopArea: json['shopArea'] as String? ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'tags': tags,
      'rating': rating,
      'reviews': reviews,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'category': category,
      'ram': ram,
      'processor': processor,
      'priceNumeric': priceNumeric,
      'cpu': cpu,
      'storage': storage,
      'gpu': gpu,
      'display': display,
      'os': os,
      'priceWeek': priceWeek,
      'priceMonth': priceMonth,
      'shopName': shopName,
      'shopArea': shopArea,
      'imageUrls': imageUrls,
    };
  }

  // ── sqflite (DB) ────────────────────────────────────
  factory Laptop.fromDb(Map<String, dynamic> map) {
    return Laptop(
      id: map['id'] as int,
      title: map['title'] as String,
      price: map['price'] as String,
      tags: (map['tags'] as String).split(','),
      rating: map['rating'] as double,
      reviews: map['reviews'] as int,
      imageUrl: map['imageUrl'] as String,
      isAvailable: (map['isAvailable'] as int) == 1,
      category: map['category'] as String,
      ram: map['ram'] as String,
      processor: map['processor'] as String,
      priceNumeric: map['priceNumeric'] as double,
      cpu: map['cpu'] as String? ?? '',
      storage: map['storage'] as String? ?? '',
      gpu: map['gpu'] as String? ?? '',
      display: map['display'] as String? ?? '',
      os: map['os'] as String? ?? '',
      priceWeek: map['priceWeek'] as String? ?? '',
      priceMonth: map['priceMonth'] as String? ?? '',
      shopName: map['shopName'] as String? ?? '',
      shopArea: map['shopArea'] as String? ?? '',
      imageUrls: (map['imageUrls'] as String).split('|||'),
    );
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'tags': tags.join(','),
      'rating': rating,
      'reviews': reviews,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable ? 1 : 0,
      'category': category,
      'ram': ram,
      'processor': processor,
      'priceNumeric': priceNumeric,
      'cpu': cpu,
      'storage': storage,
      'gpu': gpu,
      'display': display,
      'os': os,
      'priceWeek': priceWeek,
      'priceMonth': priceMonth,
      'shopName': shopName,
      'shopArea': shopArea,
      'imageUrls': imageUrls.join('|||'),
    };
  }

  @override
  List<Object?> get props => [id, title];
}
