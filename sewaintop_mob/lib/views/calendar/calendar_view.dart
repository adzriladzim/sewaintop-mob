import 'package:flutter/material.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Latar belakang abu-abu muda
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Kalender Unit',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- 1. DROPDOWN PILIHAN LAPTOP ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: 'ASUS ROG Strix G15',
                  items: const [
                    DropdownMenuItem(value: 'ASUS ROG Strix G15', child: Text('ASUS ROG Strix G15', style: TextStyle(fontWeight: FontWeight.w600))),
                  ],
                  onChanged: (value) {},
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- 2. PILIHAN UNIT FILTER ---
            Row(
              children: [
                _buildUnitButton('Unit 1', true),
                const SizedBox(width: 8),
                _buildUnitButton('Unit 2', false),
                const SizedBox(width: 8),
                _buildUnitButton('Unit 3', false),
              ],
            ),
            const SizedBox(height: 24),

            // --- 3. KOTAK KALENDER UTAMA ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  // --- HEADER JUNI 2026 ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: const Icon(Icons.chevron_left, color: Colors.grey), onPressed: () {}),
                      const Text('Juni 2026', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      IconButton(icon: const Icon(Icons.chevron_right, color: Colors.grey), onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- LABEL HARI (Sen, Sel, Rab...) ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min']
                        .map((day) => Expanded(child: Center(child: Text(day, style: const TextStyle(color: Colors.grey, fontSize: 12)))))
                        .toList(),
                  ),
                  const SizedBox(height: 12),

                  // --- GRID TANGGAL MANUAL ---
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 8, // Jarak vertikal antar baris
                      crossAxisSpacing: 0, // Tidak ada jarak horizontal agar latar belakang menyambung
                      childAspectRatio: 1, // Memastikan bentuk kotak
                    ),
                    itemCount: 35, // 5 baris minggu (5 x 7 hari)
                    itemBuilder: (context, index) {
                      // Dummy perhitungan tanggal (Tanggal 1 jatuh di hari Senin untuk Juni 2026 dummy ini)
                      int dayNumber = index + 1;
                      if (dayNumber > 31) return const SizedBox(); // Batas tanggal

                      // --- LOGIKA WARNA & BENTUK ---
                      Color bgColor = Colors.transparent;
                      Color textColor = Colors.black87;
                      BorderRadius? customRadius;

                      // Status: Perbaikan (Tgl 10, 11) -> Kotak merah muda biasa
                      if (dayNumber == 10 || dayNumber == 11) {
                        bgColor = Colors.red.shade100;
                        textColor = Colors.red;
                        customRadius = BorderRadius.circular(4); // Sedikit membulat di ujung
                      }
                      
                      // Status: Disewa (Tgl 15 - 20) -> Biru menyambung
                      else if (dayNumber >= 15 && dayNumber <= 20) {
                        bgColor = Colors.blueAccent;
                        textColor = Colors.white;
                        
                        // Membuat ujung kiri (tgl 15) dan kanan (tgl 20) bulat setengah lingkaran
                        if (dayNumber == 15) {
                          customRadius = const BorderRadius.horizontal(left: Radius.circular(30));
                        } else if (dayNumber == 20) {
                          customRadius = const BorderRadius.horizontal(right: Radius.circular(30));
                        } else {
                          customRadius = BorderRadius.zero; // Kotak menyambung di tengah (16, 17, 18, 19)
                        }
                      }
                      
                      // Status: Disewa (Tgl 25 - 28) -> Biru menyambung
                      else if (dayNumber >= 25 && dayNumber <= 28) {
                        bgColor = Colors.blueAccent;
                        textColor = Colors.white;
                        
                        if (dayNumber == 25) {
                          customRadius = const BorderRadius.horizontal(left: Radius.circular(30));
                        } else if (dayNumber == 28) {
                          customRadius = const BorderRadius.horizontal(right: Radius.circular(30));
                        } else {
                          customRadius = BorderRadius.zero;
                        }
                      }

                      // Khusus tanggal 19 (lingkaran putih di dalam balok biru - "Hari ini")
                      Widget dayText = Text('$dayNumber', style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 13));
                      
                      if (dayNumber == 19) {
                         dayText = Container(
                           margin: const EdgeInsets.all(2), // Memberikan sedikit jarak agar bentuk lingkaran terlihat
                           decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                           child: Center(child: Text('$dayNumber', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 13))),
                         );
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 2), // Sedikit jarak vertikal agar tidak menempel antar baris
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: customRadius ?? BorderRadius.circular(20), // Default bulat jika tidak ada status
                        ),
                        child: Center(child: dayText),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // --- 4. LEGEND / KETERANGAN WARNA ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLegendItem(Colors.blueAccent, 'Disewa'),
                      _buildLegendItem(Colors.red.shade100, 'Perbaikan'),
                      _buildLegendItem(Colors.grey.shade300, 'Tersedia'), // Kotak outline
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- 5. DETAIL KARTU DI BAWAH KALENDER ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1593640408182-31c70c8268f5?w=500&q=80',
                      width: 60, height: 60, fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(width: 60, height: 60, color: Colors.grey.shade200, child: const Icon(Icons.laptop, color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rafi Prasetyo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.calendar_today_outlined, size: 12, color: Colors.grey),
                            SizedBox(width: 4),
                            Text('15 Jun – 20 Jun 2026', style: TextStyle(color: Colors.black54, fontSize: 11)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Rp 750.000', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.greenAccent.shade100, borderRadius: BorderRadius.circular(12)),
                        child: Text('Disewa', style: TextStyle(color: Colors.green.shade700, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 24),
                      const Text('Lihat Detail', style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi bantuan
  Widget _buildUnitButton(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black54,
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12, height: 12, 
          decoration: BoxDecoration(
            color: label == 'Tersedia' ? Colors.transparent : color,
            border: Border.all(color: label == 'Tersedia' ? Colors.grey.shade300 : color),
            shape: BoxShape.circle,
          )
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}