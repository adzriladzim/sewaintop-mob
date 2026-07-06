// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:sewaintop_mob/constants/app_colors.dart';
import 'package:sewaintop_mob/models/laptop_model.dart';
import 'package:sewaintop_mob/views/booking/booking_request_screen.dart'; // Import booking request screen

class LaptopDetailScreen extends StatefulWidget {
  final Laptop laptop;

  const LaptopDetailScreen({super.key, required this.laptop});

  @override
  State<LaptopDetailScreen> createState() => _LaptopDetailScreenState();
}

class _LaptopDetailScreenState extends State<LaptopDetailScreen> {
  int _currentImageIndex = 0;
  int _selectedPricingTier = 0; // 0: Hari, 1: Minggu, 2: Bulan
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final laptop = widget.laptop;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable Body Content
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Swipe Gallery Carousel
                  Stack(
                    children: [
                      SizedBox(
                        height: 320,
                        width: double.infinity,
                        child: PageView.builder(
                          itemCount: laptop.imageUrls.length,
                          onPageChanged: (int index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Image.network(
                              laptop.imageUrls[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade100,
                                  child: const Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      // Carousel Indicator Dots
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            laptop.imageUrls.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentImageIndex == index
                                    ? AppColors.primary
                                    : Colors.white.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 2. Laptop Title and Availability Badge Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                laptop.title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: laptop.isAvailable
                                    ? AppColors.accent
                                    : Colors.red.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                laptop.isAvailable ? 'Tersedia' : 'Habis',
                                style: TextStyle(
                                  color: laptop.isAvailable
                                      ? AppColors.accentText
                                      : Colors.red.shade700,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Rating & Reviews row
                        Row(
                          children: [
                            Text(
                              laptop.rating.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '· ${laptop.reviews} ulasan · ${laptop.shopArea}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // 3. Pricing Tier Selector
                        Row(
                          children: [
                            _buildPricingCard(
                              index: 0,
                              label: 'Per Hari',
                              value: laptop.price.replaceAll('/hari', '').replaceAll('Rp ', 'Rp '),
                            ),
                            const SizedBox(width: 8),
                            _buildPricingCard(
                              index: 1,
                              label: 'Per Minggu',
                              value: laptop.priceWeek,
                            ),
                            const SizedBox(width: 8),
                            _buildPricingCard(
                              index: 2,
                              label: 'Per Bulan',
                              value: laptop.priceMonth,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // 4. Spesifikasi (Specifications Grid)
                        const Text(
                          'Spesifikasi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 2.3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: [
                            _buildSpecCard(Icons.developer_board_outlined, laptop.cpu, 'CPU'),
                            _buildSpecCard(Icons.memory_outlined, laptop.ram, 'RAM'),
                            _buildSpecCard(Icons.storage_outlined, laptop.storage, 'Storage'),
                            _buildSpecCard(Icons.videogame_asset_outlined, laptop.gpu, 'GPU'),
                            _buildSpecCard(Icons.desktop_windows_outlined, laptop.display, 'Display'),
                            _buildSpecCard(Icons.settings_suggest_outlined, laptop.os, 'OS'),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // 5. Ketersediaan (Availability Calendar)
                        const Text(
                          'Ketersediaan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildCalendar(),
                        const SizedBox(height: 24),

                        // 6. Lapak Info (Shop Info Card)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.cardBorder, width: 1),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.storefront,
                                  color: Colors.grey.shade600,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      laptop.shopName,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      laptop.shopArea,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.phone_outlined,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 120), // Extra space for sticky footer
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top Header Bar Overlay (Back & Favorite buttons)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleActionButton(
                  icon: Icons.arrow_back,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildCircleActionButton(
                  icon: _isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorited ? Colors.red : null,
                  onTap: () {
                    setState(() {
                      _isFavorited = !_isFavorited;
                    });
                  },
                ),
              ],
            ),
          ),

          // Bottom Sticky Footer
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: 24,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: const Border(
                  top: BorderSide(color: AppColors.cardBorder, width: 1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  )
                ],
              ),
              child: Row(
                children: [
                  // Favorite Outline Button
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.cardBorder, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isFavorited = !_isFavorited;
                        });
                      },
                      icon: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorited ? Colors.red : AppColors.textMuted,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Sewa Sekarang Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingRequestScreen(laptop: laptop),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Sewa Sekarang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleActionButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Icon(
          icon,
          color: color ?? AppColors.textDark,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildPricingCard({
    required int index,
    required String label,
    required String value,
  }) {
    final isSelected = _selectedPricingTier == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPricingTier = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.cardBorder,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.primary : AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecCard(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder.withOpacity(0.5), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.textMuted,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    // Custom June 2026 Grid as shown in the screenshot:
    // Sunday (Min) starts on Day 1.
    // Days 10, 11, 12, 13, 14, 20, 21, 22 are highlighted.
    // Days 5 have blue outlines.
    final List<String> weekdays = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    final List<int?> days = List.generate(30, (index) => index + 1);

    // Ranges to highlight
    final Set<int> highlightedDays = {10, 11, 12, 13, 14, 20, 21, 22};
    final Set<int> outlinedDays = {5};

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Column(
        children: [
          // Month header: < Juni 2026 >
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_left, size: 20),
                onPressed: () {},
              ),
              const Text(
                'Juni 2026',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_right, size: 20),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdays.map((day) {
              return SizedBox(
                width: 32,
                child: Text(
                  day,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),

          // Days Grid (5 rows)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 35, // 5 rows x 7 columns
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              if (index >= days.length) {
                return const SizedBox(); // empty cells
              }
              final day = days[index]!;
              final isHighlighted = highlightedDays.contains(day);
              final isOutlined = outlinedDays.contains(day);



              return Container(
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? const Color(0xFFFEF2F2)
                      : null,
                  borderRadius: isHighlighted ? BorderRadius.circular(8) : null,
                  border: isOutlined
                      ? Border.all(color: AppColors.primary, width: 1.5)
                      : null,
                  shape: isOutlined ? BoxShape.circle : BoxShape.rectangle,
                ),
                child: Center(
                  child: Text(
                    day.toString(),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: (isHighlighted || isOutlined)
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isOutlined
                          ? AppColors.primary
                          : (isHighlighted ? const Color(0xFFEF4444) : AppColors.textDark),
                      decoration: isHighlighted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
