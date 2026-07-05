// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:sewaintop_mob/constants/app_colors.dart';
import 'package:sewaintop_mob/models/laptop_model.dart';
import 'package:sewaintop_mob/views/home/widgets/filter_bottom_sheet.dart'; // Import bottom sheet
import 'package:sewaintop_mob/views/detail/laptop_detail_screen.dart'; // Import detail screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  String _selectedSort = 'Harga Terendah';
  final TextEditingController _searchController = TextEditingController();

  // Track favorited items
  final Set<String> _favoritedLaptops = {};

  // Active filter criteria state
  late FilterCriteria _activeCriteria;

  final List<String> _categories = [
    'Semua',
    'Gaming',
    'Office',
    'Design',
    'Video Editing'
  ];

  final List<Laptop> _laptops = [
    Laptop(
      title: 'ASUS ROG Strix G15',
      price: 'Rp 150.000/hari',
      tags: ['16GB', 'RTX 4060'],
      rating: 4.9,
      reviews: 18,
      imageUrl: 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=600&q=80',
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
      imageUrls: [
        'https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=600&q=80',
        'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=600&q=80',
        'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?auto=format&fit=crop&w=600&q=80',
      ],
    ),
    Laptop(
      title: 'Lenovo Legion 5',
      price: 'Rp 130.000/hari',
      tags: ['16GB', 'RTX 3060'],
      rating: 4.7,
      reviews: 9,
      imageUrl: 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?auto=format&fit=crop&w=600&q=80',
      category: 'Gaming',
      ram: '16GB',
      processor: 'AMD Ryzen',
      priceNumeric: 130000.0,
      isAvailable: true,
      cpu: 'AMD Ryzen 7-6800H',
      storage: '512 GB NVMe',
      gpu: 'RTX 3060',
      display: '15.6" 165Hz',
      os: 'Windows 11 Home',
      priceWeek: 'Rp 780rb',
      priceMonth: 'Rp 2.8jt',
      shopName: 'Mega Rental Indo',
      shopArea: 'Senen, Jakarta Pusat',
      imageUrls: [
        'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?auto=format&fit=crop&w=600&q=80',
        'https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=600&q=80',
      ],
    ),
    Laptop(
      title: 'MacBook Pro 14',
      price: 'Rp 250.000/hari',
      tags: ['18GB', 'M3 Pro'],
      rating: 4.9,
      reviews: 21,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=600&q=80',
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
      imageUrls: [
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=600&q=80',
        'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?auto=format&fit=crop&w=600&q=80',
      ],
    ),
    Laptop(
      title: 'Dell XPS 13',
      price: 'Rp 110.000/hari',
      tags: ['8GB', 'Intel i7'],
      rating: 4.6,
      reviews: 15,
      imageUrl: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=600&q=80',
      category: 'Office',
      ram: '8GB',
      processor: 'Intel Core',
      priceNumeric: 110000.0,
      isAvailable: true,
      cpu: 'Intel Core i7-1260P',
      storage: '512 GB SSD',
      gpu: 'Intel Iris Xe Graphics',
      display: '13.4" FHD+ Touch',
      os: 'Windows 11 Home',
      priceWeek: 'Rp 650rb',
      priceMonth: 'Rp 2.3jt',
      shopName: 'Rafa Tech Laptop',
      shopArea: 'Mangga Dua, Jakarta Barat',
      imageUrls: [
        'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=600&q=80',
      ],
    ),
    Laptop(
      title: 'HP Victus 16',
      price: 'Rp 95.000/hari',
      tags: ['8GB', 'RTX 3050'],
      rating: 4.4,
      reviews: 8,
      imageUrl: 'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?auto=format&fit=crop&w=600&q=80',
      category: 'Gaming',
      ram: '8GB',
      processor: 'Intel Core',
      priceNumeric: 95000.0,
      isAvailable: false,
      cpu: 'Intel Core i5-12500H',
      storage: '512 GB NVMe',
      gpu: 'RTX 3050',
      display: '16.1" 144Hz FHD',
      os: 'Windows 11 Home',
      priceWeek: 'Rp 580rb',
      priceMonth: 'Rp 2.0jt',
      shopName: 'Computer Square',
      shopArea: 'Kuningan, Jakarta Selatan',
      imageUrls: [
        'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?auto=format&fit=crop&w=600&q=80',
      ],
    ),
    Laptop(
      title: 'MacBook Air M2',
      price: 'Rp 140.000/hari',
      tags: ['8GB', 'M2 Chip'],
      rating: 4.8,
      reviews: 18,
      imageUrl: 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?auto=format&fit=crop&w=600&q=80',
      category: 'Office',
      ram: '8GB',
      processor: 'Apple M-series',
      priceNumeric: 140000.0,
      isAvailable: true,
      cpu: 'Apple M2 (8-core)',
      storage: '256 GB Unified',
      gpu: '8-core GPU',
      display: '13.6" Liquid Retina',
      os: 'macOS Sonoma',
      priceWeek: 'Rp 820rb',
      priceMonth: 'Rp 3.0jt',
      shopName: 'Apple Space Jakarta',
      shopArea: 'Sudirman, Jakarta Selatan',
      imageUrls: [
        'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?auto=format&fit=crop&w=600&q=80',
      ],
    ),
    Laptop(
      title: 'ASUS ZenBook Duo',
      price: 'Rp 280.000/hari',
      tags: ['32GB', 'Dual Screen'],
      rating: 4.7,
      reviews: 6,
      imageUrl: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=600&q=80',
      category: 'Design',
      ram: '32GB',
      processor: 'Intel Core',
      priceNumeric: 280000.0,
      isAvailable: true,
      cpu: 'Intel Core i9-13900H',
      storage: '2 TB NVMe SSD',
      gpu: 'Intel Iris Xe Graphics',
      display: '14.5" OLED 120Hz Touch',
      os: 'Windows 11 Pro',
      priceWeek: 'Rp 1.7jt',
      priceMonth: 'Rp 6.0jt',
      shopName: 'Mega Rental Indo',
      shopArea: 'Senen, Jakarta Pusat',
      imageUrls: [
        'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=600&q=80',
      ],
    ),
    Laptop(
      title: 'Acer Aspire 5',
      price: 'Rp 60.000/hari',
      tags: ['4GB', 'Core i3'],
      rating: 4.1,
      reviews: 5,
      imageUrl: 'https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?auto=format&fit=crop&w=600&q=80',
      category: 'Office',
      ram: '4GB',
      processor: 'Intel Core',
      priceNumeric: 60000.0,
      isAvailable: true,
      cpu: 'Intel Core i3-1115G4',
      storage: '256 GB SSD',
      gpu: 'Intel UHD Graphics',
      display: '14" HD LED',
      os: 'Windows 10 Home',
      priceWeek: 'Rp 360rb',
      priceMonth: 'Rp 1.3jt',
      shopName: 'Computer Square',
      shopArea: 'Kuningan, Jakarta Selatan',
      imageUrls: [
        'https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?auto=format&fit=crop&w=600&q=80',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _activeCriteria = FilterCriteria(
      category: null,
      ram: null,
      processor: null,
      priceRange: const RangeValues(50000, 500000), // match slider bounds
      availableOnly: false,
    );
    _searchController.addListener(() {
      setState(() {}); // trigger rebuild on search query change
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Filter logic
    final filteredLaptops = _laptops.where((laptop) {
      // Search text filter
      final query = _searchController.text.toLowerCase();
      if (query.isNotEmpty && !laptop.title.toLowerCase().contains(query)) {
        return false;
      }

      // Top category chips filter (if active and not "Semua")
      if (_selectedCategoryIndex > 0) {
        final categoryName = _categories[_selectedCategoryIndex];
        if (laptop.category != categoryName) {
          return false;
        }
      }

      // Bottom sheet criteria filters
      if (_activeCriteria.category != null &&
          laptop.category != _activeCriteria.category) {
        return false;
      }
      if (_activeCriteria.ram != null && laptop.ram != _activeCriteria.ram) {
        return false;
      }
      if (_activeCriteria.processor != null &&
          laptop.processor != _activeCriteria.processor) {
        return false;
      }
      if (laptop.priceNumeric < _activeCriteria.priceRange.start ||
          laptop.priceNumeric > _activeCriteria.priceRange.end) {
        return false;
      }
      if (_activeCriteria.availableOnly && !laptop.isAvailable) {
        return false;
      }

      return true;
    }).toList();

    // 2. Sorting logic
    if (_selectedSort == 'Harga Terendah') {
      filteredLaptops.sort((a, b) => a.priceNumeric.compareTo(b.priceNumeric));
    } else if (_selectedSort == 'Harga Tertinggi') {
      filteredLaptops.sort((a, b) => b.priceNumeric.compareTo(a.priceNumeric));
    } else if (_selectedSort == 'Rating Tertinggi') {
      filteredLaptops.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (_selectedSort == 'Terbaru') {
      // Keep natural list order
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              
              // 1. Header Row (Halo, Rafi + Bell Notification)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Halo, Rafi',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        '👋',
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                          size: 28,
                          color: AppColors.textDark,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: const Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 2. Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.cardBorder, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari laptop sewa...',
                    hintStyle: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 15,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textMuted,
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        icon: const Icon(
                          Icons.tune,
                          color: AppColors.primary,
                        ),
                        onPressed: () async {
                          final result = await showModalBottomSheet<FilterCriteria>(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => FilterBottomSheet(
                              initialCriteria: _activeCriteria,
                              totalMatchCount: filteredLaptops.length,
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              _activeCriteria = result;
                              // Synchronize top category chips with bottom sheet if category is set
                              if (result.category != null) {
                                final idx = _categories.indexOf(result.category!);
                                if (idx != -1) {
                                  _selectedCategoryIndex = idx;
                                }
                              } else {
                                _selectedCategoryIndex = 0; // Reset to "Semua"
                              }
                            });
                          }
                        },
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 3. Category Chips (Horizontal Scrollable)
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategoryIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.cardBorder,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _categories[index],
                            style: TextStyle(
                              color: isSelected ? AppColors.primary : AppColors.textMuted,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // 4. Sorting Row (Urutan: Harga Terendah)
              Row(
                children: [
                  const Text(
                    'Urutan: ',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.cardBorder, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        value: _selectedSort,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.textMuted,
                          size: 20,
                        ),
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedSort = newValue;
                            });
                          }
                        },
                        items: <String>[
                          'Harga Terendah',
                          'Harga Tertinggi',
                          'Rating Tertinggi',
                          'Terbaru'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 5. Laptop List
              Expanded(
                child: filteredLaptops.isEmpty
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
                                      _selectedCategoryIndex = 0;
                                      _activeCriteria = FilterCriteria(
                                        category: null,
                                        ram: null,
                                        processor: null,
                                        priceRange: const RangeValues(50000, 500000),
                                        availableOnly: false,
                                      );
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade50,
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
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 20),
                        itemCount: filteredLaptops.length,
                        itemBuilder: (context, index) {
                          final laptop = filteredLaptops[index];
                          final isFavorited = _favoritedLaptops.contains(laptop.title);

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
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.cardBorder, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.01),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Rounded Image with Error Handling
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                width: 100,
                                height: 90,
                                child: Image.network(
                                  laptop.imageUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey.shade100,
                                      child: const Center(
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    // Fallback layout as requested: Empty image placeholder/icon
                                    return Container(
                                      color: Colors.grey.shade100,
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        color: Colors.grey.shade400,
                                        size: 36,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Details Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title & Heart Toggle Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          laptop.title,
                                          style: const TextStyle(
                                            fontSize: 16,
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
                                            if (isFavorited) {
                                              _favoritedLaptops.remove(laptop.title);
                                            } else {
                                              _favoritedLaptops.add(laptop.title);
                                            }
                                          });
                                        },
                                        child: Icon(
                                          isFavorited
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFavorited
                                              ? Colors.red
                                              : AppColors.textMuted,
                                          size: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),

                                  // Tags Row
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

                                  // Price Text
                                  Text(
                                    laptop.price,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),

                                  // Bottom Row (Rating & Availability)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Rating
                                      Row(
                                        children: [
                                          Text(
                                            laptop.rating.toString(),
                                            style: const TextStyle(
                                              color: AppColors.textDark,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
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

                                      // Availability Pill
                                      if (laptop.isAvailable)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.accent,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            'Tersedia',
                                            style: TextStyle(
                                              color: AppColors.accentText,
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
            ],
          ),
        ),
      ),
    );
  }
}
