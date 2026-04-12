import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';

class AppRoutes {
  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes => {
        login: (_) => const LoginScreen(),
      };
}