import 'package:flutter/material.dart';
import 'package:sewaintop_mob/constants/app_colors.dart';
import 'package:sewaintop_mob/views/favorite/favorite_screen.dart'; // Import FavoriteScreen

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    const Color warningText = Color(0xFFEF4444); // Red for Keluar
    const Color roleBgColor = Color(0xFFEFF6FF); // Light blue
    const Color roleTextColor = AppColors.primary; // Blue

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profil',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            // 1. User Info Card (RP avatar + Name + Edit Profile button)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder, width: 1),
              ),
              child: Column(
                children: [
                  // Blue Avatar Circle "RP"
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'RP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Name & Email
                  const Text(
                    'Rafi Prasetyo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'rafi@email.com',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Role Badge: Penyewa
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: roleBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Penyewa',
                      style: TextStyle(
                        color: roleTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Edit Profil Text link (as in image)
                  GestureDetector(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit_outlined, color: AppColors.primary, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Edit Profil',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Outlined button: Edit Profil
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Edit Profil',
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
            const SizedBox(height: 16),

            // 2. Personal Info list card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder, width: 1),
              ),
              child: Column(
                children: [
                  _buildProfileRow(
                    icon: Icons.person_outline,
                    label: 'Nama',
                    value: 'Rafi Prasetyo',
                  ),
                  const Divider(height: 1, color: AppColors.cardBorder),
                  _buildProfileRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: 'rafi@email.com',
                  ),
                  const Divider(height: 1, color: AppColors.cardBorder),
                  _buildProfileRow(
                    icon: Icons.phone_outlined,
                    label: 'No. HP',
                    value: '+62 812-xxxx-xxxx',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. Settings & Preferences card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder, width: 1),
              ),
              child: Column(
                children: [
                  // Row 1: Notifikasi (Toggle)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: Row(
                      children: [
                        const Icon(Icons.notifications_none_outlined, color: AppColors.textMuted, size: 22),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Notifikasi',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        Switch(
                          value: _notificationsEnabled,
                          activeThumbColor: Colors.white,
                          activeTrackColor: AppColors.primary,
                          inactiveTrackColor: Colors.grey.shade200,
                          onChanged: (bool value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.cardBorder),

                  // Row 2: Bahasa
                  _buildProfileRow(
                    icon: Icons.language_outlined,
                    label: 'Bahasa',
                    value: 'Indonesia',
                  ),
                  const Divider(height: 1, color: AppColors.cardBorder),

                  // Row 3: Wishlist Saya (UPGRADED Wishlist Option)
                  _buildProfileRow(
                    icon: Icons.favorite_border_outlined,
                    label: 'Wishlist Saya',
                    textColor: const Color.fromARGB(255, 0, 0, 0), // Highlight wishlist
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoriteScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, color: AppColors.cardBorder),

                  // Row 4: Bantuan & FAQ
                  _buildProfileRow(
                    icon: Icons.help_outline_outlined,
                    label: 'Bantuan & FAQ',
                  ),
                  const Divider(height: 1, color: AppColors.cardBorder),

                  // Row 5: Kebijakan Privasi
                  _buildProfileRow(
                    icon: Icons.security_outlined,
                    label: 'Kebijakan Privasi',
                  ),
                  const Divider(height: 1, color: AppColors.cardBorder),

                  // Row 6: Beri Penilaian App
                  _buildProfileRow(
                    icon: Icons.star_outline,
                    label: 'Beri Penilaian App',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4. Log Out button (Red text, thin border)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: warningText,
                  side: const BorderSide(color: warningText, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Keluar',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 5. App version
            const Center(
              child: Text(
                'SewaIn v1.0.0',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow({
    required IconData icon,
    required String label,
    String? value,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textMuted, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? AppColors.textDark,
                ),
              ),
            ),
            if (value != null) ...[
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
