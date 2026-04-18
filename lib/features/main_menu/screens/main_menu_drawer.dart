import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import 'color_themes_screen.dart';

// ─────────────────────────────────────────────────────────────────
//  MODEL MENU ITEM
// ─────────────────────────────────────────────────────────────────
class _MenuItem {
  final IconData icon;
  final String label;
  final int? badge;

  const _MenuItem({
    required this.icon,
    required this.label,
    this.badge,
  });
}

// ─────────────────────────────────────────────────────────────────
//  DATA MENU
// ─────────────────────────────────────────────────────────────────
const List<_MenuItem> _menuItems = [
  _MenuItem(icon: Icons.home_outlined,         label: 'Home'),
  _MenuItem(icon: Icons.shopping_cart_outlined, label: 'My Order'),
  _MenuItem(icon: Icons.notifications_outlined, label: 'Notifications', badge: 2),
  _MenuItem(icon: Icons.person_outline,         label: 'Profile'),
  _MenuItem(icon: Icons.mail_outline,           label: 'Message'),
  _MenuItem(icon: Icons.grid_view_outlined,     label: 'Elements'),
  _MenuItem(icon: Icons.settings_outlined,      label: 'Setting'),
  _MenuItem(icon: Icons.power_settings_new,     label: 'Logout'),
];

// ─────────────────────────────────────────────────────────────────
//  MAIN MENU DRAWER
// ─────────────────────────────────────────────────────────────────
class MainMenuDrawer extends StatefulWidget {
  /// Index halaman yang sedang aktif (0 = Home, 1 = My Order, dst.)
  final int activeIndex;

  /// Callback saat item menu ditekan
  final ValueChanged<int>? onItemTap;

  const MainMenuDrawer({
    super.key,
    this.activeIndex = 0,
    this.onItemTap,
  });

  @override
  State<MainMenuDrawer> createState() => _MainMenuDrawerState();
}

class _MainMenuDrawerState extends State<MainMenuDrawer> {
  late int _activeIndex;

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.activeIndex;
  }

  void _onTap(int index) {
    // Logout — tampilkan dialog konfirmasi
    if (_menuItems[index].label == 'Logout') {
      _showLogoutDialog();
      return;
    }

    // Setting — buka Color Themes
    if (_menuItems[index].label == 'Setting') {
      Navigator.of(context).pop(); // tutup drawer dulu
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const ColorThemesScreen()),
      );
      return;
    }

    setState(() => _activeIndex = index);
    widget.onItemTap?.call(index);
    Navigator.of(context).pop(); // tutup drawer
  }

  void _showLogoutDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Keluar?',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        content: Text(
          'Apakah kamu yakin ingin keluar dari akun?',
          style: TextStyle(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: TextStyle(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(80, 38),
              backgroundColor: AppColors.primaryGreen,
            ),
            onPressed: () {
              Navigator.pop(context); // tutup dialog
              Navigator.pop(context); // tutup drawer
              // TODO: aksi logout
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.72,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight:    Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: Tombol Close + Judul ──────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Main Menu',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? AppColors.dividerDark
                              : AppColors.dividerLight,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ── Menu Items ────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  final isActive = index == _activeIndex;
                  final isLogout = item.label == 'Logout';

                  return _MenuTile(
                    item: item,
                    isActive: isActive,
                    isLogout: isLogout,
                    isDark: isDark,
                    onTap: () => _onTap(index),
                  );
                },
              ),
            ),

            // ── Footer: Nama App & Versi ───────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
                    height: 24,
                  ),
                  Text(
                    'Sayur Healthy Food',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'App Version 1.0.1',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
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

// ─────────────────────────────────────────────────────────────────
//  WIDGET: Menu Tile
// ─────────────────────────────────────────────────────────────────
class _MenuTile extends StatelessWidget {
  final _MenuItem item;
  final bool isActive;
  final bool isLogout;
  final bool isDark;
  final VoidCallback onTap;

  const _MenuTile({
    required this.item,
    required this.isActive,
    required this.isLogout,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor  = isDark ? AppColors.primaryGreenLight : AppColors.primaryGreen;
    final inactiveColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final iconColor    = isActive ? activeColor : inactiveColor;
    final textColor    = isActive
        ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
        : inactiveColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: isActive
                  ? (isDark ? AppColors.primaryBgDark : AppColors.primaryBg)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Icon
                Icon(item.icon, size: 22, color: iconColor),
                const SizedBox(width: 14),

                // Label
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                ),

                // Badge notifikasi
                if (item.badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${item.badge}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}