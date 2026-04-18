import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/messages/screens/message_list_screen.dart';
import '../features/messages/screens/chat_detail.dart';
import '../features/food/screens/orders_screen.dart';
import '../features/main_menu/screens/color_themes_screen.dart';
import '../features/main_menu/screens/main_menu_drawer.dart';




class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String messageList = '/message-list';
  static const String chatDetail = '/chat-detail';
  static const String orders = '/orders';
  static const String colorThemes = '/color-themes';
  static const String mainMenu = '/mainmenu';

  // Tambahkan ini agar 'AppRoutes.routes' di main.dart tidak error
  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    messageList: (context) => const MessageListScreen(),
    chatDetail: (context) => const ChatDetailScreen(),
    orders: (context) => const OrdersScreen(),
    colorThemes: (context) => const ColorThemesScreen(),
    mainMenu: (context) => const MainMenuDrawer(),
  };

  // Tambahkan ini agar 'AppRoutes.onGenerateRoute' di main.dart tidak error
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case messageList:
        return MaterialPageRoute(builder: (_) => const MessageListScreen());
      case chatDetail:
        return MaterialPageRoute(builder: (_) => const ChatDetailScreen());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Halaman tidak ditemukan')),
          ),
        );
    }
  }
}
