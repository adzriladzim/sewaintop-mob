import 'package:flutter/material.dart';

class AddLaptopView extends StatelessWidget {
  const AddLaptopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Nanti ini untuk tombol kembali
          },
        ),
        title: const Text(
          'Tambah Laptop',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Simpan', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. FOTO LAPTOP ---
            const Text('Foto Laptop', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 12),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 1.5), // Garis pinggir
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, color: Colors.grey, size: 32),
                  SizedBox(height: 8),
                  Text('Masukkan URL Foto', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildTextField('https://...'),
            const SizedBox(height: 24),

            // --- 2. INFORMASI DASAR ---
            const Text('Informasi Dasar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 12),
            _buildTextField('Nama Laptop'),
            const SizedBox(height: 12),
            _buildDropdown('ASUS'),
            const SizedBox(height: 24),

            // --- 3. KATEGORI ---
            const Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChip('Gaming', true),
                _buildChip('Office', false),
                _buildChip('Design', false),
                _buildChip('Video Editing', false),
              ],
            ),
            const SizedBox(height: 24),

            // --- 4. SPESIFIKASI ---
            const Text('Spesifikasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildTextField('Prosesor')),
                const SizedBox(width: 12),
                Expanded(child: _buildDropdown('16GB')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildTextField('Storage')),
                const SizedBox(width: 12),
                Expanded(child: _buildTextField('GPU')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildTextField('Display')),
                const SizedBox(width: 12),
                Expanded(child: _buildDropdown('Windows 11')),
              ],
            ),
            const SizedBox(height: 24),

            // --- 5. HARGA SEWA ---
            const Text('Harga Sewa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildPriceField('Per Hari (Rp)')),
                const SizedBox(width: 8),
                Expanded(child: _buildPriceField('Per Minggu (Rp)')),
                const SizedBox(width: 8),
                Expanded(child: _buildPriceField('Per Bulan (Rp)')),
              ],
            ),
            const SizedBox(height: 24),

            // --- 6. JUMLAH UNIT & TOMBOL SIMPAN ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jumlah unit tersedia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Row(
                  children: [
                    _buildCounterButton(Icons.remove, Colors.white, Colors.black),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    _buildCounterButton(Icons.add, Colors.blue, Colors.white),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text('Simpan Laptop', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
            
            // Tombol Hapus
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text('Hapus Laptop', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // FUNGSI BANTUAN UNTUK FORM
  // =========================================================

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildPriceField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(height: 6),
        _buildTextField('0'),
      ],
    );
  }

  Widget _buildDropdown(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: const [], // Kosong dulu karena ini dummy UI
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.blue : Colors.transparent),
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

  Widget _buildCounterButton(IconData icon, Color bgColor, Color iconColor) {
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: bgColor == Colors.white ? Colors.grey.shade300 : Colors.transparent),
      ),
      child: Icon(icon, color: iconColor, size: 18),
    );
  }
}