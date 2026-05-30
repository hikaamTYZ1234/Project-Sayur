import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme_provider.dart';
import '../../../theme/app_colors.dart';

// ============================================================
// MODEL
// ============================================================
class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  const ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });
}

// ============================================================
// DUMMY DATA
// ============================================================
final List<ChatMessage> dummyChats = [
  const ChatMessage(
    text: 'Hi Roberto, what courses you taket for this week?',
    isMe: false,
    time: '10:00 AM',
  ),
  const ChatMessage(
    text: 'Maybe UI Design or Foreign Language',
    isMe: true,
    time: '10:02 AM',
  ),
  const ChatMessage(
    text: 'OK. Good Luck mate',
    isMe: false,
    time: '10:03 AM',
  ),
  const ChatMessage(
    text: 'Thank You.',
    isMe: true,
    time: '10:04 AM',
  ),
];

// ============================================================
// SCREEN
// ============================================================
class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = List.from(dummyChats);

  // Auto-reply responses per slug
  static const Map<String, List<String>> _autoReplies = {
    'sam-verdinand': [
      'Hei! Ada yang bisa saya bantu? 😊',
      'Tentu, saya siap membantu!',
      'Oke, saya mengerti. Terima kasih!',
      'Boleh, nanti saya cek dulu ya.',
    ],
    'freddie-ronan': [
      'Yo! What\'s up? 🤙',
      'Sure thing, bro!',
      'Got it, I\'ll check that out.',
      'Sounds good to me!',
    ],
    'ethan-jacoby': [
      'Hello! How can I help? 👋',
      'Noted, I\'ll get back to you.',
      'That\'s a great idea!',
      'Let me think about that...',
    ],
    'alfie-manson': [
      'Hey there! 😄',
      'Interesting, tell me more!',
      'I agree with you on that.',
      'Will do, thanks!',
    ],
    'archie-parker': [
      'Hi! Nice to hear from you.',
      'Sure, no problem!',
      'I\'ll take care of it.',
      'Thanks for letting me know!',
    ],
  };

  static const List<String> _defaultReplies = [
    'Halo! Ada yang bisa saya bantu? 😊',
    'Baik, saya mengerti.',
    'Terima kasih pesannya!',
    'Oke, nanti saya balas ya.',
  ];

  int _replyIndex = 0;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String slug) {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isMe: true, time: _currentTime()));
    });
    _messageController.clear();
    _scrollToBottom();

    // Auto-reply after 800ms
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      final replies = _autoReplies[slug] ?? _defaultReplies;
      final reply = replies[_replyIndex % replies.length];
      setState(() {
        _replyIndex++;
        _messages.add(ChatMessage(text: reply, isMe: false, time: _currentTime()));
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _currentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final slug   = args?['slug']   as String? ?? '';
    final name   = args?['name']   as String? ?? 'Chat';
    final avatar = args?['avatar'] as String? ?? '';

    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(isDark, name, avatar),
            _buildOldMessagesLabel(isDark),
            Expanded(child: _buildChatList(isDark)),
            _buildInputBar(isDark, slug),
          ],
        ),
      ),
    );
  }

  // ---- HEADER ----
  Widget _buildHeader(bool isDark, String name, String avatar) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: isDark ? AppColors.iconDark : AppColors.iconLight,
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 42,
              height: 42,
              child: avatar.isNotEmpty
                  ? Image.asset(
                      avatar,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _avatarFallback(isDark),
                    )
                  : _avatarFallback(isDark),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'ONLINE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_vert_rounded,
              size: 22,
              color: isDark ? AppColors.iconDark : AppColors.iconLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarFallback(bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      child: Icon(Icons.person, color: isDark ? AppColors.iconDark : AppColors.iconLight),
    );
  }

  // ---- "See old messages" label ----
  Widget _buildOldMessagesLabel(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'See old messages',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark
                    ? AppColors.textHintDark
                    : AppColors.textHintLight,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  // ---- CHAT LIST ----
  Widget _buildChatList(bool isDark) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return _buildChatBubble(_messages[index], isDark);
      },
    );
  }

  Widget _buildChatBubble(ChatMessage msg, bool isDark) {
    final isMe = msg.isMe;

    // Warna bubble
    Color bubbleColor;
    Color textColor;
    if (isMe) {
      bubbleColor = AppColors.success; // Hijau untuk pesan sendiri
      textColor = Colors.white;
    } else {
      bubbleColor = isDark ? AppColors.surfaceDark : const Color(0xFFEEEEEE);
      textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Bubble
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 18),
                ),
              ),
              child: Text(
                msg.text,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  height: 1.4,
                ),
              ),
            ),
            // Time
            const SizedBox(height: 4),
            Text(
              msg.time,
              style: TextStyle(
                fontSize: 10,
                color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- INPUT BAR ----
  Widget _buildInputBar(bool isDark, String slug) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.attach_file_rounded,
              size: 22,
              color: isDark ? AppColors.iconDark : AppColors.iconLight,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _messageController,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(slug),
              style: TextStyle(
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(
                  color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                filled: true,
                fillColor: isDark ? AppColors.surfaceDark : const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: AppColors.success, width: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => _sendMessage(slug),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.success,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}