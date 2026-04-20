import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/theme_provider.dart';
import '../../../theme/app_colors.dart';

// ============================================================
// MODEL
// ============================================================
class MessageModel {
  final String name;
  final String preview;
  final String time;
  final String avatarPath; // REVISI: Menggunakan path asset lokal
  final bool isRead;

  const MessageModel({
    required this.name,
    required this.preview,
    required this.time,
    required this.avatarPath,
    required this.isRead,
  });
}

// ============================================================
// DUMMY DATA (Input dari folder assets)
// ============================================================
const List<MessageModel> dummyMessages = [
  MessageModel(
    name: 'Sam Verdinand',
    preview: 'OK. Lorem ipsum dolor sect...',
    time: '2m ago',
    avatarPath:
        'assets/vanpersi.png', // Sesuaikan dengan nama file di folder assets Anda
    isRead: true,
  ),
  MessageModel(
    name: 'Freddie Ronan',
    preview: 'OK. Lorem ipsum dolor sect...',
    time: '2m ago',
    avatarPath: 'assets/fereddie.png',
    isRead: false,
  ),
  MessageModel(
    name: 'Ethan Jacoby',
    preview: 'OK. Lorem ipsum dolor sect...',
    time: '2m ago',
    avatarPath: 'assets/ethan.png',
    isRead: true,
  ),
  MessageModel(
    name: 'alfie manson',
    preview: 'OK. Lorem ipsum dolor sect...',
    time: '2m ago',
    avatarPath: 'assets/alfiemanson.png',
    isRead: false,
  ),
  MessageModel(
    name: 'archie parker',
    preview: 'OK. Lorem ipsum dolor sect...',
    time: '2m ago',
    avatarPath: 'assets/archieparker.png',
    isRead: true,
  ),
];

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(isDark),
            _buildSearchBar(isDark),
            Expanded(child: _buildMessageList(isDark)),
          ],
        ),
      ),
    );
  }

  // ---- HEADER & SEARCH BAR ----
  Widget _buildHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.maybePop(context);
              } else {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              }
            },
            isDark: isDark,
          ),
          Text(
            'Messages List',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          _iconButton(
            icon: Icons.person_outline_rounded,
            onTap: () => Navigator.pushNamed(context, AppRoutes.chatDetail),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 22,
        color: isDark ? AppColors.iconDark : AppColors.iconLight,
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Find messages here...',
          prefixIcon: Icon(
            Icons.search_rounded,
            color: isDark ? AppColors.iconDark : AppColors.iconLight,
          ),
        ),
      ),
    );
  }

  // ---- MESSAGE LIST ----
  Widget _buildMessageList(bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: dummyMessages.length,
      itemBuilder: (context, index) =>
          _buildMessageItem(dummyMessages[index], isDark),
    );
  }

  Widget _buildMessageItem(MessageModel msg, bool isDark) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.chatDetail),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Row(
          children: [
            // REVISI: Menggunakan Image.asset untuk input lokal
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 54,
                height: 54,
                child: Image.asset(
                  msg.avatarPath,
                  fit: BoxFit.cover,
                  // Placeholder jika file asset tidak ditemukan
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: isDark
                        ? AppColors.surfaceDark
                        : AppColors.surfaceLight,
                    child: Icon(
                      Icons.person,
                      color: isDark ? AppColors.iconDark : AppColors.iconLight,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        msg.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                      ),
                      _buildStatusIndicator(msg.isRead),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    msg.preview,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    msg.time,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.textHintDark
                          : AppColors.textHintLight,
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

  Widget _buildStatusIndicator(bool isRead) {
    return Row(
      children: [
        Text(
          isRead ? 'Read' : 'Pending',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isRead ? AppColors.success : AppColors.warning,
          ),
        ),
        const SizedBox(width: 2),
        Icon(
          Icons.check_rounded,
          size: 14,
          color: isRead ? AppColors.success : AppColors.warning,
        ),
      ],
    );
  }
}
