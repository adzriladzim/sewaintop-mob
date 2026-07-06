import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. KOTAK KPI PENDAPATAN ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200, width: 1.5),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pendapatan Bulan Ini',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rp 8.500.000',
                    style: TextStyle(
                      color: Colors.green, // Warna hijau
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'dari 12 transaksi selesai',
                    style: TextStyle(color: Colors.black38, fontSize: 12),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),

            // --- 2. TOMBOL FILTER BULAN ---
            Row(
              children: [
                _buildMonthButton('Mei', false),
                const SizedBox(width: 10),
                _buildMonthButton('Jun 2026', true),
                const SizedBox(width: 10),
                _buildMonthButton('Jul', false),
              ],
            ),

            const SizedBox(height: 20),

            // --- 3. DAFTAR TRANSAKSI (DUMMY DATA LENGKAP) ---
            _buildTransactionCard(
              inisial: 'RP', color: Colors.blue,
              nama: 'Rafi Prasetyo', barang: 'ASUS ROG G15',
              durasi: '5 hari', tanggal: '15 Jun - 20 Jun 2026',
              harga: 'Rp 750.000', status: 'Selesai', statusColor: Colors.green.shade100, statusTextColor: Colors.green,
            ),
            const SizedBox(height: 12),
            
            _buildTransactionCard(
              inisial: 'DS', color: Colors.blue.shade700,
              nama: 'Dian Saputra', barang: 'ThinkPad X1 Carbon',
              durasi: '6 hari', tanggal: '22 Jun - 28 Jun 2026',
              harga: 'Rp 540.000', status: 'Selesai', statusColor: Colors.green.shade100, statusTextColor: Colors.green,
            ),
            const SizedBox(height: 12),
            
            // ---> TAMBAHAN: MAYA <---
            _buildTransactionCard(
              inisial: 'ML', color: Colors.blue.shade300,
              nama: 'Maya Lestari', barang: 'MacBook Air M2',
              durasi: '4 hari', tanggal: '10 Jun - 14 Jun 2026',
              harga: 'Rp 540.000', status: 'Selesai', statusColor: Colors.green.shade100, statusTextColor: Colors.green,
            ),
            const SizedBox(height: 12),
            
            // ---> TAMBAHAN: BUDI <---
            _buildTransactionCard(
              inisial: 'BS', color: Colors.indigo,
              nama: 'Budi Santoso', barang: 'Dell XPS 15',
              durasi: '5 hari', tanggal: '18 Jun - 23 Jun 2026',
              harga: 'Rp 650.000', status: 'Selesai', statusColor: Colors.green.shade100, statusTextColor: Colors.green,
            ),
            const SizedBox(height: 12),
            
            _buildTransactionCard(
              inisial: 'RD', color: Colors.blue.shade400,
              nama: 'Rina Dewi', barang: 'Lenovo IdeaPad',
              durasi: '3 hari', tanggal: '12 Jun - 14 Jun 2026',
              harga: 'Rp 300.000', status: 'Dibatalkan', statusColor: Colors.grey.shade200, statusTextColor: Colors.grey.shade700,
            ),
            const SizedBox(height: 12),
            
            // ---> TAMBAHAN: ANDI <---
            _buildTransactionCard(
              inisial: 'AK', color: Colors.blueAccent,
              nama: 'Andi Kurniawan', barang: 'HP Pavilion',
              durasi: '2 hari', tanggal: '25 Jun - 26 Jun 2026',
              harga: 'Rp 250.000', status: 'Dibatalkan', statusColor: Colors.grey.shade200, statusTextColor: Colors.grey.shade700,
            ),
            
            // Tambahkan jarak kosong di bawah supaya tidak tertutup tulisan total
            const SizedBox(height: 40),
          ],
        ),
      ),
      
      // --- 4. BAR BAWAH (TOTAL PENDAPATAN) ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.blue.shade100, width: 2)),
        ),
        child: const Text(
          'Total: Rp 8.500.000 - 12 transaksi',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // --- FUNGSI BANTUAN UNTUK BIKIN TOMBOL BULAN ---
  Widget _buildMonthButton(String title, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300, 
          width: 1.5
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black54,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // --- FUNGSI BANTUAN UNTUK BIKIN KARTU TRANSAKSI ---
  Widget _buildTransactionCard({
    required String inisial, required Color color,
    required String nama, required String barang,
    required String durasi, required String tanggal,
    required String harga, required String status,
    required Color statusColor, required Color statusTextColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 20,
            child: Text(inisial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(barang, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(durasi, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                    ),
                    const SizedBox(width: 8),
                    Text(tanggal, style: const TextStyle(fontSize: 11, color: Colors.black38)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(harga, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(status, style: TextStyle(color: statusTextColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}