import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isDarkMode = false;

  // --- Color Tokens ---
  static const _green = Color(0xFF2ECC71);

  Color get _bg => _isDarkMode ? const Color(0xFF121212) : Colors.white;
  Color get _textPrimary =>
      _isDarkMode ? Colors.white : const Color(0xFF1A1A1A);
  Color get _textSecondary =>
      _isDarkMode ? const Color(0xFF9E9E9E) : const Color(0xFF757575);
  Color get _divider =>
      _isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xFFE0E0E0);

  // Notification data
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
      'time': '7h ago',
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
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  return _buildNotificationItem(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back arrow
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Icon(Icons.arrow_back, color: _textPrimary, size: 26),
          ),

          // Title
          Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),

          // Profile icon + dark mode toggle
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _isDarkMode = !_isDarkMode),
                child: Icon(
                  _isDarkMode
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  color: _textPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.person_outline, color: _textPrimary, size: 26),
            ],
          ),
        ],
      ),
    );
  }

  // ── Notification Item ────────────────────────────────────────────────────
  Widget _buildNotificationItem(int index) {
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
                        color: _green,
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
                      color: isRead ? _textSecondary : _textPrimary,
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
                    color: _textSecondary,
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
                        color: _textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _markAsRead(index),
                      child: Text(
                        'Mark as read',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isRead ? _textSecondary : _green,
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
        Divider(color: _divider, thickness: 1, height: 1),
      ],
    );
  }
}
