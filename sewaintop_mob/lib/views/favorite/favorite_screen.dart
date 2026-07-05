import 'package:flutter/material.dart';
import 'package:sewaintop_mob/constants/app_colors.dart';
import 'package:sewaintop_mob/models/laptop_model.dart';
import 'package:sewaintop_mob/views/detail/laptop_detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Mock favorites list matching the screenshot
  final List<Laptop> _favorites = [
    Laptop(
      id: 1,
      title: 'ASUS ROG Strix G15',
      price: 'Rp 150.000/hari',
      tags: ['16GB', 'RTX 4070'],
      rating: 4.9,
      reviews: 12,
      imageUrl: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=300&q=80',
      category: 'Gaming',
      ram: '16GB',
      processor: 'AMD Ryzen',
      priceNumeric: 150000.0,
      isAvailable: true,
      cpu: 'Intel i9-13900H',
      storage: '1 TB NVMe',
      gpu: 'RTX 4070',
      display: '15.6" 144Hz',
      os: 'Windows 11 Pro',
      priceWeek: 'Rp 900rb',
      priceMonth: 'Rp 3.2jt',
      shopName: 'Rafa Tech Laptop',
      shopArea: 'Mangga Dua, Jakarta Barat',
      imageUrls: ['https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=600&q=80'],
    ),
    Laptop(
      id: 3,
      title: 'MacBook Pro 14',
      price: 'Rp 250.000/hari',
      tags: ['18GB', 'M3 Pro'],
      rating: 4.9,
      reviews: 21,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=300&q=80',
      category: 'Design',
      ram: '16GB',
      processor: 'Apple M-series',
      priceNumeric: 250000.0,
      isAvailable: true,
      cpu: 'Apple M3 Pro (11-core)',
      storage: '512 GB Unified',
      gpu: '14-core GPU',
      display: '14.2" Liquid Retina XDR',
      os: 'macOS Sonoma',
      priceWeek: 'Rp 1.5jt',
      priceMonth: 'Rp 5.2jt',
      shopName: 'Apple Space Jakarta',
      shopArea: 'Sudirman, Jakarta Selatan',
      imageUrls: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=600&q=80'],
    ),
    Laptop(
      id: 2,
      title: 'Lenovo ThinkPad X1',
      price: 'Rp 120.000/hari',
      tags: ['16GB', 'Intel i7'],
      rating: 4.7,
      reviews: 9,
      imageUrl: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=300&q=80',
      category: 'Office',
      ram: '16GB',
      processor: 'Intel Core',
      priceNumeric: 120000.0,
      isAvailable: false, // Show as Rented/Disewa
      cpu: 'Intel Core i7-1260P',
      storage: '512 GB SSD',
      gpu: 'Intel Iris Xe Graphics',
      display: '14" WUXGA',
      os: 'Windows 11 Pro',
      priceWeek: 'Rp 700rb',
      priceMonth: 'Rp 2.5jt',
      shopName: 'Mega Rental Indo',
      shopArea: 'Senen, Jakarta Pusat',
      imageUrls: ['https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=600&q=80'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Favorit',
              style: TextStyle(
                color: AppColors.textDark,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Laptop yang kamu simpan (${_favorites.length})',
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF1F2), // soft pink/red
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.heart_broken_outlined,
                        color: Color(0xFFF43F5E), // rose/red
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Belum ada favorit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Simpan laptop yang kamu suka agar mudah ditemukan lagi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 140,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Cari Laptop',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _favorites.length,
                    itemBuilder: (context, index) {
                      final laptop = _favorites[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LaptopDetailScreen(laptop: laptop),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.cardBorder, width: 1),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  width: 100,
                                  height: 90,
                                  child: Image.network(
                                    laptop.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: Colors.grey.shade100,
                                      child: const Icon(Icons.computer, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            laptop.title,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textDark,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _favorites.removeAt(index);
                                            });
                                          },
                                          child: const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: laptop.tags.map((tag) {
                                        return Container(
                                          margin: const EdgeInsets.only(right: 6),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            tag,
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      laptop.price,
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              laptop.rating.toString(),
                                              style: const TextStyle(
                                                color: AppColors.textMuted,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 14,
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              '(${laptop.reviews})',
                                              style: const TextStyle(
                                                color: AppColors.textMuted,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: laptop.isAvailable
                                                ? AppColors.accent
                                                : const Color(0xFFDBEAFE), // Light blue for Rented
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            laptop.isAvailable ? 'Tersedia' : 'Disewa',
                                            style: TextStyle(
                                              color: laptop.isAvailable
                                                  ? AppColors.accentText
                                                  : AppColors.primary, // Blue for Rented text
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: TextButton(
                    onPressed: () {
                      // Navigate back to Beranda (pops back to root)
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text(
                      'Jelajahi Lebih Banyak Laptop →',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
