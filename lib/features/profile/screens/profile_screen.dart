import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;

  // --- Color Tokens ---
  static const _green = Color(0xFF2ECC71);
  static const _greenDark = Color(0xFF1A2C1F); // dark icon bg
  static const _greenLight = Color(0xFFE8F8EE); // light icon bg

  Color get _bg => _isDarkMode ? const Color(0xFF121212) : Colors.white;
  Color get _surface => _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
  Color get _textPrimary =>
      _isDarkMode ? Colors.white : const Color(0xFF1A1A1A);
  Color get _textSecondary =>
      _isDarkMode ? const Color(0xFF9E9E9E) : const Color(0xFF757575);
  Color get _divider =>
      _isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE);
  Color get _iconBg => _isDarkMode ? _greenDark : _greenLight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              const SizedBox(height: 16),
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildUserInfo(),
              const SizedBox(height: 24),
              _buildContactIcons(),
              const SizedBox(height: 24),
              Divider(color: _divider, thickness: 1, indent: 24, endIndent: 24),
              const SizedBox(height: 20),
              _buildSavedMenu(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Hamburger menu
          GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 2.5,
                  decoration: BoxDecoration(
                    color: _textPrimary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 18,
                  height: 2.5,
                  decoration: BoxDecoration(
                    color: _textPrimary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 24,
                  height: 2.5,
                  decoration: BoxDecoration(
                    color: _textPrimary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),

          // Title
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),

          // Edit + dark mode toggle
          Row(
            children: [
              // Dark mode toggle (tambahan fitur)
              GestureDetector(
                onTap: () => setState(() => _isDarkMode = !_isDarkMode),
                child: Icon(
                  _isDarkMode
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  color: _textPrimary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.edit_outlined, color: _textPrimary, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Profile Header Card ──────────────────────────────────────────────────
  Widget _buildProfileHeader() {
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
                color: _green,
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
              border: Border.all(
                color: _isDarkMode ? const Color(0xFF121212) : Colors.white,
                width: 4,
              ),
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
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
              // Fallback jika asset belum ada
              child: Icon(Icons.person, size: 48, color: Colors.white),
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
  Widget _buildUserInfo() {
    return Center(
      child: Column(
        children: [
          Text(
            'London, England',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: _textSecondary),
              const SizedBox(width: 4),
              Text(
                'London, England',
                style: TextStyle(fontSize: 14, color: _textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Contact Icons ────────────────────────────────────────────────────────
  Widget _buildContactIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildContactItem(Icons.phone_outlined, 'Telephone'),
          _buildContactItem(Icons.email_outlined, 'Email'),
          _buildContactItem(Icons.location_on_outlined, 'Address'),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(color: _iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: _green, size: 26),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 13, color: _textSecondary)),
      ],
    );
  }

  // ── Saved Menu ───────────────────────────────────────────────────────────
  Widget _buildSavedMenu() {
    final List<Map<String, String>> savedItems = [
      {
        'title': 'Fresh Green Salad',
        'category': 'Salad',
        'image': 'assets/images/salad.jpg',
      },
      {
        'title': 'Apple Juice Special',
        'category': 'Juice',
        'image': 'assets/images/juice.jpg',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saved Menu',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
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
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 180,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image background — use AssetImage; fallback to colored container
            Container(
              color: _isDarkMode
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFFE0F2E9),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback gradient when asset not found
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _green.withOpacity(0.6),
                          _green.withOpacity(0.3),
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

            // Gradient overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.65)],
                ),
              ),
            ),

            // Text labels
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
