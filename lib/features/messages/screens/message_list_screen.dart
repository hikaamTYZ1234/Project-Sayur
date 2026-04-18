import 'package:flutter/material.dart';

// ============================================================
// MODEL
// ============================================================
class MessageModel {
  final String name;
  final String preview;
  final String time;
  final String avatarUrl;
  final bool isRead;

  const MessageModel({
    required this.name,
    required this.preview,
    required this.time,
    required this.avatarUrl,
    required this.isRead,
  });
}

// ============================================================
// DUMMY DATA
// ============================================================
const List<MessageModel> dummyMessages = [
  MessageModel(
    name: 'Sam Verdinand',
    preview: 'OK. Lorem ipsum dolor sect...',
    time: '2m ago',
    avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    isRead: true,
  ),
  MessageModel(
    name: 'Freddie Ronan',
    preview: 'OK. Lorem ipsum dolor sect...',
    time: '2m ago',
    avatarUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
    isRead: false,
  ),
  MessageModel(
    name: 'Ethan Jacoby',
    preview: 'OK. Lorem ipsum dolor sect...',
    time: '2m ago',
    avatarUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
    isRead: true,
  ),
  MessageModel(
    name: 'Alfie Mason',
    preview: 'OK. Lorem ipsum dolor sect...',
    time: '2m ago',
    avatarUrl: 'https://randomuser.me/api/portraits/men/76.jpg',
    isRead: false,
  ),
  MessageModel(
    name: 'Archie Parker',
    preview: 'OK. Lorem ipsum dolor sect...',
    time: '2m ago',
    avatarUrl: 'https://randomuser.me/api/portraits/men/52.jpg',
    isRead: true,
  ),
];

// ============================================================
// SCREEN
// ============================================================
class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  bool _isDarkMode = true;
  final TextEditingController _searchController = TextEditingController();

  // ---- THEME COLORS ----------------------------------------
  Color get bgColor       => _isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF2F2F2);
  Color get surface2Color => _isDarkMode ? const Color(0xFF2E2E2E) : const Color(0xFFF9F9F9);
  Color get borderColor   => _isDarkMode ? const Color(0xFF333333) : const Color(0xFFE0E0E0);
  Color get textPrimary   => _isDarkMode ? const Color(0xFFF0F0F0) : const Color(0xFF1A1A1A);
  Color get textSecondary => _isDarkMode ? const Color(0xFF888888) : const Color(0xFF555555);
  Color get textMeta      => _isDarkMode ? const Color(0xFF555555) : const Color(0xFF999999);
  Color get inputBg       => _isDarkMode ? const Color(0xFF2A2A2A) : const Color(0xFFFFFFFF);
  Color get iconColor     => _isDarkMode ? const Color(0xFF888888) : const Color(0xFFAAAAAA);
  Color get readColor     => _isDarkMode ? const Color(0xFF4CAF50) : const Color(0xFF2E7D32);
  Color get pendingColor  => _isDarkMode ? const Color(0xFF888888) : const Color(0xFF999999);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: bgColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildThemeToggle(),
              _buildSearchBar(),
              Expanded(child: _buildMessageList()),
            ],
          ),
        ),
      ),
    );
  }

  // ---- HEADER ----------------------------------------------
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.maybePop(context),
          ),
          Text(
            'Messages List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: textPrimary,
              letterSpacing: 0.3,
            ),
          ),
          _iconButton(
            icon: Icons.person_outline_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _iconButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(icon, size: 22, color: textSecondary),
      ),
    );
  }

  // ---- THEME TOGGLE ----------------------------------------
  Widget _buildThemeToggle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '🌙 Dark',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => setState(() => _isDarkMode = !_isDarkMode),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 46,
              height: 26,
              decoration: BoxDecoration(
                color: _isDarkMode
                    ? const Color(0xFF333333)
                    : const Color(0xFFCCCCCC),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: 3,
                    left: _isDarkMode ? 3 : 23,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _isDarkMode
                            ? const Color(0xFFF0F0F0)
                            : const Color(0xFF1A1A1A),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '☀️ Light',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // ---- SEARCH BAR ------------------------------------------
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: inputBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: iconColor, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: 'Find food here...',
                  hintStyle: TextStyle(
                    color: _isDarkMode
                        ? const Color(0xFF555555)
                        : const Color(0xFFBBBBBB),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- MESSAGE LIST ----------------------------------------
  Widget _buildMessageList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: dummyMessages.length,
      itemBuilder: (context, index) {
        return _buildMessageItem(dummyMessages[index]);
      },
    );
  }

  Widget _buildMessageItem(MessageModel msg) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to chat detail
      },
      splashColor: surface2Color,
      highlightColor: surface2Color,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: borderColor, width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                msg.avatarUrl,
                width: 54,
                height: 54,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 54,
                  height: 54,
                  color: surface2Color,
                  child: Icon(Icons.person, color: iconColor),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        msg.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: textPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            msg.isRead ? 'Read' : 'Pending',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: msg.isRead ? readColor : pendingColor,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Icon(
                            Icons.check_rounded,
                            size: 14,
                            color: msg.isRead ? readColor : pendingColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    msg.preview,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    msg.time,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textMeta,
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