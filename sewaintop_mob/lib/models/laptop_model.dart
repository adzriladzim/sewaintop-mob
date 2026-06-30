class Laptop {
  final String title;
  final String price;
  final List<String> tags;
  final double rating;
  final int reviews;
  final String imageUrl;
  final bool isAvailable;

  Laptop({
    required this.title,
    required this.price,
    required this.tags,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    this.isAvailable = true,
  });
}
