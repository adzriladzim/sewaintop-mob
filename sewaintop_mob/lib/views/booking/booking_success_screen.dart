// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:sewaintop_mob/constants/app_colors.dart';
import 'package:sewaintop_mob/models/laptop_model.dart';

class BookingSuccessScreen extends StatelessWidget {
  final Laptop laptop;
  final DateTime startDate;
  final DateTime endDate;
  final int duration;
  final double total;

  const BookingSuccessScreen({
    super.key,
    required this.laptop,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.total,
  });

  String _formatFullDateRange() {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${startDate.day} ${months[startDate.month - 1]} – ${endDate.day} ${months[endDate.month - 1]} ${startDate.year}';
  }

  String _formatRupiah(double value) {
    final intVal = value.round();
    String str = intVal.toString();
    String result = '';
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      result = str[i] + result;
      count++;
      if (count == 3 && i > 0) {
        result = '.$result';
        count = 0;
      }
    }
    return 'Rp $result';
  }

  @override
  Widget build(BuildContext context) {
    const Color warningBg = Color(0xFFFEF3C7); // Light amber
    const Color warningText = Color(0xFFD97706); // Dark amber

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Decorative background pastel circles
          Positioned(
            top: 60,
            left: 30,
            child: _buildPastelDot(10, const Color(0xFFBFDBFE)), // light blue
          ),
          Positioned(
            top: 100,
            left: 60,
            child: _buildPastelDot(8, const Color(0xFFA7F3D0)), // light green
          ),
          Positioned(
            top: 180,
            left: 45,
            child: _buildPastelDot(6, const Color(0xFFFCA5A5)), // light red
          ),
          Positioned(
            top: 80,
            right: 40,
            child: _buildPastelDot(10, const Color(0xFFFDE68A)), // light yellow
          ),
          Positioned(
            top: 120,
            right: 80,
            child: _buildPastelDot(7, const Color(0xFFFFD3B6)), // light orange
          ),
          Positioned(
            top: 140,
            right: 25,
            child: _buildPastelDot(8, const Color(0xFFE2E8F0)), // light grey
          ),

          // 2. Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),

                  // Green success checkmark ring
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Text Info
                  const Text(
                    'Permintaan Terkirim!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tunggu konfirmasi dari pemilik lapak.\nBiasanya direspon dalam 1x24 jam.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Summary Box Card (with green highlight on left side)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.01),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Left green border highlight indicator
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 4,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(2)),
                            ),
                          ),
                        ),
                        // Content
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: 52,
                                  height: 44,
                                  child: Image.network(
                                    laptop.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: Colors.grey.shade100,
                                      child: const Icon(Icons.image, size: 18),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Text Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      laptop.title,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${_formatFullDateRange()} · $duration hari',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Total: ${_formatRupiah(total)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Status Badge Pill: ⏳ Menunggu Konfirmasi
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: warningBg,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '⏳',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Menunggu Konfirmasi',
                                            style: TextStyle(
                                              color: warningText,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Bottom Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Go back to home
                        Navigator.popUntil(context, (route) => route.isFirst);
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
                        'Lihat Status Sewa',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Go back to home root
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Kembali ke Beranda',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastelDot(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
