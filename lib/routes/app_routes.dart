import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';

class AppRoutes {
  static const String login = '/login';

  static const String initialRoute = login;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == login) {
      return _buildRoute(settings, const LoginScreen());
    }

    // Semua route lain ditutup
    return _blockedRoute(settings);
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
      builder: (_) => Scaffold(
        body: Center(
          child: Text(
            'Halaman belum tersedia',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}