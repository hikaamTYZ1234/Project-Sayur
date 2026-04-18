import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/messages/screens/message_list_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String messageList = '/message-list';

  // Tambahkan ini agar 'AppRoutes.routes' di main.dart tidak error
  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    messageList: (context) => const MessageListScreen(),
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
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Halaman tidak ditemukan')),
          ),
        );
    }
  }
}
