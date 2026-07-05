class Laptop {
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

  Laptop({
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
}
