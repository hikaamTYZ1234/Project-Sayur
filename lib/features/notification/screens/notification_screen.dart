import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_provider.dart';
import '../../profile/screens/profile_screen.dart'; // Ganti path ini jika letak file profilmu berbeda

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Data simulasi notifikasi - Sekarang berisi 8 item sesuai desain
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Apply Success',
      'message': 'You has apply an job in Queenify Group as UI Designer',
      'time': '10h ago',
      'isUnread': true,
      'isRead': false,
    },
    {
      'title': 'Interview Calls',
      'message': 'Congratulations! You have interview calls',
      'time': '9h ago',
      'isUnread': true,
      'isRead': false,
    },
    {
      'title': 'Apply Success',
      'message': 'You has apply an job in Queenify Group as UI Designer',
      'time': '8h ago',
      'isUnread': false,
      'isRead': false,
    },
    {
      'title': 'Complete your profile',
      'message':
          'Please verify your profile information to continue using this app',
      'time': '4h ago',
      'isUnread': false,
      'isRead': false,
    },
    {
      'title': 'Apply Success',
      'message': 'You has apply an job in Queenify Group as UI Designer',
      'time': '10h ago',
      'isUnread': false,
      'isRead': false,
    },
    {
      'title': 'Interview Calls',
      'message': 'Congratulations! You have interview calls',
      'time': '9h ago',
      'isUnread': false,
      'isRead': false,
    },
    // ---- Tambahan item ke-7 dan ke-8 ----
    {
      'title': 'Apply Success',
      'message': 'You has apply an job in Queenify Group as UI Designer',
      'time': '8h ago',
      'isUnread': false,
      'isRead': false,
    },
    {
      'title': 'Complete your profile',
      'message':
          'Please verify your profile information to continue using this app',
      'time': '4h ago',
      'isUnread': false,
      'isRead': false,
    },
  ];

  void _markAsRead(int index) {
    setState(() {
      _notifications[index]['isUnread'] = false;
      _notifications[index]['isRead'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    final Color bg = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color textPrimary = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color textSecondary = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final Color dividerColor = isDark
        ? AppColors.dividerDark
        : AppColors.dividerLight;
    final Color primaryGreen = isDark
        ? AppColors.primaryGreenLight
        : AppColors.primaryGreen;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context, textPrimary),
            Expanded(
              child: ListView.builder(
                itemCount:
                    _notifications.length, // Sekarang akan me-render 8 item
                itemBuilder: (context, index) {
                  return _buildNotificationItem(
                    index,
                    textPrimary,
                    textSecondary,
                    dividerColor,
                    primaryGreen,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────
  Widget _buildAppBar(BuildContext context, Color textPrimary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tombol Kembali (Kiri) - Menyesuaikan menu sebelumnya
          GestureDetector(
            onTap: () {
              // Navigator.pop akan menghapus halaman saat ini dan kembali ke halaman sebelumnya
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: Icon(Icons.arrow_back, color: textPrimary, size: 26),
          ),

          // Judul (Tengah)
          Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),

          // Ikon Profil (Kanan) - Klik untuk pindah ke Profile
          GestureDetector(
            onTap: () {
              // Navigasi pindah ke halaman ProfileScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: Icon(Icons.person_outline, color: textPrimary, size: 28),
          ),
        ],
      ),
    );
  }

  // ── Notification Item ────────────────────────────────────────────────────
  Widget _buildNotificationItem(
    int index,
    Color textPrimary,
    Color textSecondary,
    Color dividerColor,
    Color primaryGreen,
  ) {
    final item = _notifications[index];
    final bool isUnread = item['isUnread'] as bool;
    final bool isRead = item['isRead'] as bool;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isUnread) ...[
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: primaryGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isRead ? textSecondary : textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.only(left: isUnread ? 18.0 : 0),
                child: Text(
                  item['message'],
                  style: TextStyle(
                    fontSize: 14,
                    color: textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: isUnread ? 18.0 : 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['time'],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _markAsRead(index),
                      child: Text(
                        'Mark as read',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isRead ? textSecondary : primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(color: dividerColor, thickness: 1, height: 1),
      ],
    );
  }
}
