import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Memantau perubahan tema dari Provider buatan temanmu
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;
    final textTheme = Theme.of(context).textTheme;

    // Mapping warna menggunakan AppColors dari temanmu
    final Color bg = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color textPrimary = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color textSecondary = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final Color divider = isDark
        ? AppColors.dividerDark
        : AppColors.dividerLight;
    final Color iconBg = isDark ? AppColors.primaryBgDark : AppColors.primaryBg;
    final Color primaryGreen = isDark
        ? AppColors.primaryGreenLight
        : AppColors.primaryGreen;

    // Border avatar mengikuti warna background scaffold agar menyatu
    final Color avatarBorder = bg;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(textPrimary),
              const SizedBox(height: 16),
              _buildProfileHeader(primaryGreen, avatarBorder),
              const SizedBox(height: 24),
              _buildUserInfo(textTheme, textPrimary, textSecondary),
              const SizedBox(height: 24),
              _buildContactIcons(iconBg, primaryGreen, textSecondary),
              const SizedBox(height: 24),
              Divider(color: divider, thickness: 1, indent: 24, endIndent: 24),
              const SizedBox(height: 20),
              _buildSavedMenu(context, textPrimary, isDark),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────
  Widget _buildAppBar(Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Hamburger menu (Kiri)
          GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHamburgerLine(24, textColor),
                const SizedBox(height: 5),
                _buildHamburgerLine(18, textColor),
                const SizedBox(height: 5),
                _buildHamburgerLine(24, textColor),
              ],
            ),
          ),

          // Title (Tengah)
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),

          // Edit Icon (Kanan) - Tombol ganti tema sudah dihapus
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.edit_outlined, color: textColor, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildHamburgerLine(double width, Color color) {
    return Container(
      width: width,
      height: 2.5,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  // ── Profile Header Card ──────────────────────────────────────────────────
  Widget _buildProfileHeader(Color primaryGreen, Color avatarBorder) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Green stats card — sits below avatar
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.only(
                top: 56,
                bottom: 20,
                left: 24,
                right: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatColumn('237', 'Transactions'),
                  _buildStatColumn('19', 'Reviews'),
                ],
              ),
            ),
          ),

          // Avatar — overlaps card top
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: avatarBorder, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 44,
              backgroundImage: AssetImage('assets/avatar.png'),
              // Fallback jika gambar belum ditambahkan ke assets
              // child: Icon(Icons.person, size: 48, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.white70),
        ),
      ],
    );
  }

  // ── User Info ────────────────────────────────────────────────────────────
  Widget _buildUserInfo(
    TextTheme textTheme,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Center(
      child: Column(
        children: [
          Text(
            'London, England',
            style: textTheme.headlineMedium?.copyWith(
              color: textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: textSecondary),
              const SizedBox(width: 4),
              Text(
                'London, England',
                style: textTheme.bodyMedium?.copyWith(color: textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Contact Icons ────────────────────────────────────────────────────────
  Widget _buildContactIcons(
    Color iconBg,
    Color iconColor,
    Color textSecondary,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildContactItem(
            Icons.phone_outlined,
            'Telephone',
            iconBg,
            iconColor,
            textSecondary,
          ),
          _buildContactItem(
            Icons.email_outlined,
            'Email',
            iconBg,
            iconColor,
            textSecondary,
          ),
          _buildContactItem(
            Icons.location_on_outlined,
            'Address',
            iconBg,
            iconColor,
            textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String label,
    Color bgColor,
    Color iconColor,
    Color textColor,
  ) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 26),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 13, color: textColor)),
      ],
    );
  }

  // ── Saved Menu ───────────────────────────────────────────────────────────
  Widget _buildSavedMenu(BuildContext context, Color textPrimary, bool isDark) {
    final List<Map<String, String>> savedItems = [
      {
        'title': 'Fresh Green Salad',
        'category': 'Salad',
        'image': 'assets/salad.png',
      },
      {
        'title': 'Apple Juice Special',
        'category': 'Juice',
        'image': 'assets/juice.png',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saved Menu',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: savedItems.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final item = savedItems[index];
                return _buildMenuCard(
                  title: item['title']!,
                  category: item['category']!,
                  imagePath: item['image']!,
                  isDark: isDark,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required String category,
    required String imagePath,
    required bool isDark,
  }) {
    // Warna fallback jika gambar gagal dimuat
    final Color fallbackBg = isDark
        ? AppColors.surfaceVariantDark
        : AppColors.primaryBg;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 180,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Container(
              color: fallbackBg,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primaryGreen.withOpacity(0.6),
                          AppColors.primaryGreen.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      size: 48,
                      color: Colors.white54,
                    ),
                  );
                },
              ),
            ),

            // Gradient gelap dari bawah ke atas agar text bisa dibaca
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xA6000000)],
                ),
              ),
            ),

            // Text labels di atas gambar
            Positioned(
              bottom: 14,
              left: 14,
              right: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
