import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../theme/app_colors.dart';
import 'color_themes_screen.dart';
import '../../../routes/app_routes.dart';
import '../../screens/onboarding_screen.dart';


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
  _MenuItem(icon: Icons.home_outlined, label: 'Home'),
  _MenuItem(icon: Icons.shopping_cart_outlined, label: 'My Order'),
  _MenuItem(icon: Icons.notifications_outlined, label: 'Notifications', badge: 2),
  _MenuItem(icon: Icons.person_outline, label: 'Profile'),
  _MenuItem(icon: Icons.mail_outline, label: 'Message'),
  _MenuItem(icon: Icons.grid_view_outlined, label: 'Elements'),
  _MenuItem(icon: Icons.settings_outlined, label: 'Setting'),
  _MenuItem(icon: Icons.power_settings_new, label: 'Logout'),
];

// ─────────────────────────────────────────────────────────────────
//  MAIN MENU DRAWER
// ─────────────────────────────────────────────────────────────────
class MainMenuDrawer extends StatefulWidget {
  final int activeIndex;
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
    if (_menuItems[index].label == 'Logout') {
      _showLogoutDialog();
      return;
    }

    Navigator.of(context).pop();

    final label = _menuItems[index].label;

    if (label == 'Setting') {
      Navigator.of(context).pushNamed(AppRoutes.colorThemes);
    } else if (label == 'Home') {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
    } else if (label == 'My Order') {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.orders, (route) => false);
    } else if (label == 'Notifications') {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.notification, (route) => false);
    } else if (label == 'Profile') {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.profile, (route) => false);
    } else if (label == 'Message') {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.messageList, (route) => false);
    } else if (label == 'Elements') {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.elements, (route) => false);
    }
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

          // 🔥 FIX LOGOUT DI SINI
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(80, 38),
              backgroundColor: AppColors.primaryGreen,
            ),
            onPressed: () async {
              Navigator.pop(context);

              // 🔥 reset onboarding
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('hasSeenOnboarding');

              // 🔥 arahkan ke onboarding
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.onboarding,
                (route) => false,
              );
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
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  final isActive = index == _activeIndex;

                  return ListTile(
                    leading: Icon(item.icon),
                    title: Text(item.label),
                    selected: isActive,
                    onTap: () => _onTap(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}