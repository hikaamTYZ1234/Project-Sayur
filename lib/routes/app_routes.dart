import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';

  static const String initialRoute = login;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _buildRoute(settings, const LoginScreen());

      case register:
        return _buildRoute(settings, const RegisterScreen());

      default:
        return _blockedRoute(settings);
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(
      RouteSettings settings, Widget page) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => page,
    );
  }

  static MaterialPageRoute<dynamic> _blockedRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(
            'Halaman belum tersedia',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}