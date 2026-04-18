import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_provider.dart';
import '../../profile/screens/profile_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Warna hijau khusus disesuaikan dengan tema aplikasi "Sayur"
  static const Color _sayurGreen = Color(0xFF3BA660);

  // Data simulasi notifikasi (Total 8 Item)
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
    // Memantau perubahan tema dari Provider
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

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
    final Color dividerColor = isDark
        ? AppColors.dividerDark
        : AppColors.dividerLight;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context, textPrimary),
            Expanded(
              child: ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  return _buildNotificationItem(
                    index,
                    textPrimary,
                    textSecondary,
                    dividerColor,
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
          // Tombol Kembali
          GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: Icon(Icons.arrow_back, color: textPrimary, size: 26),
          ),

          // Title
          Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),

          // Ikon Profil - Pindah ke ProfileScreen saat diklik
          GestureDetector(
            onTap: () {
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
              // Title row with unread dot
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isUnread) ...[
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: _sayurGreen, // Menggunakan warna hijau khusus
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

              // Message
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

              // Time + Mark as read row
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
                          color: isRead
                              ? textSecondary
                              : _sayurGreen, // Menggunakan warna hijau khusus
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Divider
        Divider(color: dividerColor, thickness: 1, height: 1),
      ],
    );
  }
}
