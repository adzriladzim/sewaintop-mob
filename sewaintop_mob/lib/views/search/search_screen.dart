// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:sewaintop_mob/constants/app_colors.dart';
import 'package:sewaintop_mob/models/laptop_model.dart';
import 'package:sewaintop_mob/views/detail/laptop_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Mock search history keywords
  final List<String> _recentSearches = [
    'ASUS ROG',
    'MacBook M2',
    'ThinkPad',
    'RAM 16GB'
  ];

  // Popular category choices with icons
  final List<Map<String, dynamic>> _popularCategories = [
    {'name': 'Gaming', 'icon': Icons.sports_esports_outlined, 'color': Color(0xFFEFF6FF), 'iconColor': Color(0xFF3B82F6)},
    {'name': 'Office', 'icon': Icons.business_center_outlined, 'color': Color(0xFFF0FDF4), 'iconColor': Color(0xFF22C55E)},
    {'name': 'Design', 'icon': Icons.palette_outlined, 'color': Color(0xFFFAF5FF), 'iconColor': Color(0xFFA855F7)},
    {'name': 'Editing', 'icon': Icons.movie_filter_outlined, 'color': Color(0xFFFEF2F2), 'iconColor': Color(0xFFEF4444)},
  ];

  // Dummy list of laptops to search from
  final List<Laptop> _allLaptops = [
    Laptop(
      title: 'ASUS ROG Strix G15',
      price: 'Rp 150.000/hari',
      tags: ['16GB', 'RTX 4060'],
      rating: 4.9,
      reviews: 12,
      imageUrl: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=300&q=80',
      category: 'Gaming',
      ram: '16GB',
      processor: 'AMD Ryzen',
      priceNumeric: 150000.0,
      isAvailable: true,
      cpu: 'AMD Ryzen 7 6800H',
      storage: '512 GB SSD',
      gpu: 'RTX 4060 8GB',
      display: '15.6" FHD 144Hz',
      os: 'Windows 11',
      priceWeek: 'Rp 950rb',
      priceMonth: 'Rp 3.5jt',
      shopName: 'Rafa Tech Laptop',
      shopArea: 'Mangga Dua, Jakarta Barat',
      imageUrls: ['https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=600&q=80'],
    ),
    Laptop(
      title: 'MacBook Pro 14 M2',
      price: 'Rp 250.000/hari',
      tags: ['16GB', 'M2 Pro'],
      rating: 4.9,
      reviews: 21,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=300&q=80',
      category: 'Design',
      ram: '16GB',
      processor: 'Apple M-series',
      priceNumeric: 250000.0,
      isAvailable: true,
      cpu: 'Apple M2 Pro (10-core)',
      storage: '512 GB Unified',
      gpu: '16-core GPU',
      display: '14.2" Liquid Retina XDR',
      os: 'macOS Ventura',
      priceWeek: 'Rp 1.6jt',
      priceMonth: 'Rp 5.5jt',
      shopName: 'Apple Space Jakarta',
      shopArea: 'Sudirman, Jakarta Selatan',
      imageUrls: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=600&q=80'],
    ),
    Laptop(
      title: 'Lenovo ThinkPad X1 Carbon',
      price: 'Rp 120.000/hari',
      tags: ['16GB', 'Intel i7'],
      rating: 4.7,
      reviews: 9,
      imageUrl: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=300&q=80',
      category: 'Office',
      ram: '16GB',
      processor: 'Intel Core',
      priceNumeric: 120000.0,
      isAvailable: true,
      cpu: 'Intel Core i7-1260P',
      storage: '1 TB NVMe',
      gpu: 'Intel Iris Xe',
      display: '14" WUXGA IPS',
      os: 'Windows 11 Pro',
      priceWeek: 'Rp 750rb',
      priceMonth: 'Rp 2.8jt',
      shopName: 'Mega Rental Indo',
      shopArea: 'Senen, Jakarta Pusat',
      imageUrls: ['https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=600&q=80'],
    ),
    Laptop(
      title: 'MSI Katana 15 B13V',
      price: 'Rp 160.000/hari',
      tags: ['16GB', 'RTX 4060'],
      rating: 4.8,
      reviews: 14,
      imageUrl: 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?auto=format&fit=crop&w=300&q=80',
      category: 'Gaming',
      ram: '16GB',
      processor: 'Intel Core',
      priceNumeric: 160000.0,
      isAvailable: true,
      cpu: 'Intel Core i7-13620H',
      storage: '1 TB SSD',
      gpu: 'RTX 4060 8GB',
      display: '15.6" FHD 144Hz',
      os: 'Windows 11 Home',
      priceWeek: 'Rp 1.0jt',
      priceMonth: 'Rp 3.8jt',
      shopName: 'Rafa Tech Laptop',
      shopArea: 'Mangga Dua, Jakarta Barat',
      imageUrls: ['https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?auto=format&fit=crop&w=600&q=80'],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Laptop> _getFilteredLaptops() {
    if (_searchQuery.isEmpty) return [];
    return _allLaptops.where((laptop) {
      final query = _searchQuery.toLowerCase();
      return laptop.title.toLowerCase().contains(query) ||
          laptop.category.toLowerCase().contains(query) ||
          laptop.ram.toLowerCase().contains(query) ||
          laptop.processor.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredLaptops = _getFilteredLaptops();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(Icons.search, color: AppColors.textMuted, size: 20),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Cari laptop, spesifikasi, atau kategori...',
                      hintStyle: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                if (_searchQuery.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.textMuted, size: 18),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
      body: _searchQuery.isEmpty
          ? _buildDefaultSearchView()
          : _buildSearchResultsView(filteredLaptops),
    );
  }

  // Layout when user is not typing yet (Tokopedia/Shopee style default page)
  Widget _buildDefaultSearchView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Pencarian Terakhir (Recent Searches)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pencarian Terakhir',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _recentSearches.clear();
                  });
                },
                child: const Icon(
                  Icons.delete_outline,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _recentSearches.isEmpty
              ? Text(
                  'Belum ada pencarian baru-baru ini.',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _recentSearches.map((keyword) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchController.text = keyword;
                          _searchQuery = keyword;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.cardBorder, width: 1),
                        ),
                        child: Text(
                          keyword,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
          const SizedBox(height: 28),

          // 2. Kategori Populer (Popular Categories Grid)
          const Text(
            'Kategori Populer',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _popularCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final cat = _popularCategories[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _searchController.text = cat['name'];
                    _searchQuery = cat['name'];
                  });
                },
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: cat['color'],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        cat['icon'],
                        color: cat['iconColor'],
                        size: 26,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cat['name'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 28),

          // 3. Rekomendasi Untukmu (Recommendations)
          const Text(
            'Rekomendasi Untukmu',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          _buildLaptopsGrid(_allLaptops),
        ],
      ),
    );
  }

  // Layout when user is filtering laptops (Active Search Results)
  Widget _buildSearchResultsView(List<Laptop> results) {
    if (results.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF), // soft blue
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.search,
                  color: AppColors.primary, // blue
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Laptop tidak ditemukan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Coba ubah filter atau kata kunci pencarianmu',
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
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    foregroundColor: AppColors.textDark,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: AppColors.cardBorder, width: 1),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Reset Filter',
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
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ditemukan (${results.length}) laptop matching',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 12),
          _buildLaptopsGrid(results),
        ],
      ),
    );
  }

  // Premium Grid Layout for Laptops (2 columns)
  Widget _buildLaptopsGrid(List<Laptop> laptops) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: laptops.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final laptop = laptops[index];
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        laptop.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade100,
                          child: const Icon(Icons.computer, color: Colors.grey, size: 32),
                        ),
                      ),
                    ),
                  ),
                ),
                // Texts Info
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        laptop.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        laptop.price,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Rating & Reviews row
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 2),
                          Text(
                            laptop.rating.toString(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '(${laptop.reviews})',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Shop Area Location Pill
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, color: AppColors.textMuted, size: 12),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              laptop.shopArea.split(',').first,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textMuted,
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
    );
  }
}
