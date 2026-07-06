import 'package:flutter/material.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'Inventaris',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '15 unit',
                style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- 1. SEARCH BAR ---
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari laptop...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- 2. FILTER CHIPS ---
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Semua', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Tersedia', true),
                  const SizedBox(width: 8),
                  _buildFilterChip('Disewa', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Perbaikan', false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- 3. DAFTAR KARTU LAPTOP (SEKARANG PAKAI GAMBAR ASLI) ---
            _buildLaptopCard(
              imageUrl: 'https://images.unsplash.com/photo-1593640408182-31c70c8268f5?w=500&q=80', // Gambar ASUS
              nama: 'ASUS ROG Strix G15',
              spek: 'Gaming • 32GB • RTX 4070',
              harga: 'Rp 150.000/hari',
              status1: 'Tersedia (3/5 unit)',
              status2: '2 Disewa',
              status1Color: Colors.green,
              showMenu: true,
            ),
            const SizedBox(height: 16),
            _buildLaptopCard(
              imageUrl: 'https://images.unsplash.com/photo-1629131726692-1accd0c53ce0?w=500&q=80', // Gambar ThinkPad
              nama: 'ThinkPad X1 Carbon',
              spek: 'Office • 16GB • Intel i7',
              harga: 'Rp 120.000/hari',
              status1: '0/4 Tersedia',
              status2: '4 Disewa',
              status1Color: Colors.blue,
              showMenu: false,
            ),
            const SizedBox(height: 16),
            _buildLaptopCard(
              imageUrl: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500&q=80', // Gambar Dell
              nama: 'Dell XPS 15',
              spek: 'Design • 16GB • NVIDIA GTX',
              harga: 'Rp 130.000/hari',
              status1: '1 Perbaikan',
              status2: '2 Tersedia',
              status1Color: Colors.red,
              showMenu: false,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      
      // --- 4. TOMBOL TAMBAH (FAB) ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // =========================================================
  // FUNGSI BANTUAN 
  // =========================================================

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black54,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildLaptopCard({
    required String imageUrl, // <--- Ini kode baru untuk menerima link gambar
    required String nama, required String spek, required String harga,
    required String status1, required String status2,
    required Color status1Color, required bool showMenu,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---> INI BAGIAN YANG BERUBAH <---
                ClipRRect( // ClipRRect fungsinya untuk membuat sudut gambar jadi melengkung (rounded)
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 60, height: 60,
                    fit: BoxFit.cover, // Supaya gambarnya pas dan tidak gepeng
                    errorBuilder: (context, error, stackTrace) {
                      // Kalau link gambarnya mati/rusak, dia akan otomatis nampilin kotak abu-abu lagi
                      return Container(
                        width: 60, height: 60,
                        color: Colors.grey.shade100,
                        child: const Icon(Icons.laptop_mac, color: Colors.grey),
                      );
                    },
                  ),
                ),
                // ---------------------------------
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text(spek, style: const TextStyle(color: Colors.black54, fontSize: 10)),
                      const SizedBox(height: 8),
                      Text(harga, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.circle, size: 8, color: status1Color),
                          const SizedBox(width: 4),
                          Text(status1, style: TextStyle(color: status1Color, fontSize: 10, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
                            child: Text(status2, style: const TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, color: Colors.grey, size: 20),
              ],
            ),
          ),
          
          if (showMenu) ...[
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            _buildMenuRow('Edit', Colors.black87),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            _buildMenuRow('Update Status', Colors.black87),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            _buildMenuRow('Hapus', Colors.red),
          ]
        ],
      ),
    );
  }

  Widget _buildMenuRow(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}