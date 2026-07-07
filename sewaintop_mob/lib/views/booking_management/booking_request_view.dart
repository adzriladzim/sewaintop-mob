import 'package:flutter/material.dart';

class BookingRequestView extends StatelessWidget {
  const BookingRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Permintaan Masuk',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- 1. TABS NAVIGATION ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabItem('Perlu Diproses (3)', true),
                _buildTabItem('Sudah Diproses', false),
                _buildTabItem('Semua', false),
              ],
            ),
          ),
          
          // --- 2. LIST PERMINTAAN ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildRequestCard(
                  inisial: 'RP', color: Colors.blue, indicatorColor: Colors.orange,
                  nama: 'Rafi Prasetyo', rating: 'Belum ada ulasan',
                  laptopName: 'ASUS ROG G15', 
                  imageUrl: 'https://images.unsplash.com/photo-1593640408182-31c70c8268f5?w=500&q=80',
                  kategori: 'Gaming',
                  tanggal: '15 Jun – 20 Jun 2026', durasi: '5 hari',
                  totalPrice: 'Rp 750.000', note: 'Perlu tas laptop',
                  statusLabel: '', statusColor: Colors.transparent, statusTextColor: Colors.transparent,
                  isNeedAction: true, showSeen: false,
                ),
                const SizedBox(height: 16),
                _buildRequestCard(
                  inisial: 'DS', color: Colors.blue.shade700, indicatorColor: Colors.greenAccent.shade400,
                  nama: 'Dian Saputra', rating: 'Belum ada ulasan',
                  laptopName: 'ThinkPad X1 Carbon', 
                  imageUrl: 'https://images.unsplash.com/photo-1629131726692-1accd0c53ce0?w=500&q=80',
                  kategori: 'Business',
                  tanggal: '22 Jun – 28 Jun 2026', durasi: '6 hari',
                  totalPrice: 'Rp 540.000', note: '',
                  statusLabel: 'Disetujui', statusColor: Colors.greenAccent.shade100, statusTextColor: Colors.green.shade700,
                  isNeedAction: false, showSeen: true,
                ),
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    children: [
                      Icon(Icons.inbox_outlined, color: Colors.grey.shade300, size: 32),
                      const SizedBox(height: 8),
                      Text('Tidak ada permintaan lagi', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.blue : Colors.black54,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildRequestCard({
    required String inisial, required Color color, required Color indicatorColor,
    required String nama, required String rating,
    required String laptopName, required String imageUrl, required String kategori,
    required String tanggal, required String durasi,
    required String totalPrice, required String note,
    required String statusLabel, required Color statusColor, required Color statusTextColor,
    required bool isNeedAction, required bool showSeen,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        // Menambahkan garis warna di sebelah kiri kartu
        boxShadow: [
          BoxShadow(color: indicatorColor, offset: const Offset(-4, 0)),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar, Nama, Ulasan & Label Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: color, radius: 18, child: Text(inisial, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Row(
                        children: [
                          const Icon(Icons.star_border, color: Colors.grey, size: 12), // Bintang tidak nyala
                          const SizedBox(width: 4),
                          Text(rating, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              if (statusLabel.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(12)),
                  child: Text(statusLabel, style: TextStyle(color: statusTextColor, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Konten: Gambar Laptop & Kategori
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  imageUrl, width: 40, height: 40, fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(width: 40, height: 40, color: Colors.grey.shade200, child: const Icon(Icons.laptop, color: Colors.grey)),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(laptopName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                    child: Text(kategori, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          
          // Tanggal & Durasi
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.black54),
              const SizedBox(width: 6),
              Text(tanggal, style: const TextStyle(color: Colors.black87, fontSize: 12)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                child: Text(durasi, style: const TextStyle(color: Colors.grey, fontSize: 10)),
              )
            ],
          ),
          const SizedBox(height: 12),
          
          // Harga (Warna Hitam)
          Text(totalPrice, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),

          // Catatan Penyewa (Jika ada)
          if (note.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.chat_bubble_outline, size: 12, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(note, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
              ),
            ),
          
          // Aksi (Tombol Terima/Tolak atau Chat)
          if (isNeedAction)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Tolak', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C853), // Warna hijau yang lebih cerah sesuai desain
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Terima', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                if (showSeen) ...[
                  const Text('Dilihat', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Chat', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}