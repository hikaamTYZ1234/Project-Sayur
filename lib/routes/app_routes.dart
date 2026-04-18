import 'package:flutter/material.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/screens/onboarding_screen.dart';

// import lain boleh tetap ada (tidak masalah)

class AppRoutes {
  // ── Route name constants ──────────────────────────────────────────────────
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';

  // (tetap disimpan tapi NONAKTIF)
  static const String home = '/home';
  static const String detailFood = '/detail-food';
  static const String detailLocation = '/detail-location';
  static const String messages = '/messages';
  static const String notification = '/notification';
  static const String profile = '/profile';
  static const String search = '/search';
  static const String elements = '/elements';

  // ── Initial route ─────────────────────────────────────────────────────────
  static const String initialRoute = onboarding;

  // ── Route map (AKTIF HANYA 3) ────────────────────────────────────────────
  static Map<String, WidgetBuilder> get routes => {
        onboarding: (_) => const OnboardingScreen(),
        login: (_) => const LoginScreen(),
        register: (_) => const RegisterScreen(),
      };

  // ── onGenerateRoute (DIKUNCI) ────────────────────────────────────────────
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Hanya izinkan 3 route ini
    if (settings.name == onboarding ||
        settings.name == login ||
        settings.name == register) {
      return MaterialPageRoute(
        builder: (context) => routes[settings.name]!(context),
      );
    }

    // Semua route lain dimatikan
    return _notFoundRoute(settings);
  }

  // ── 404 page ─────────────────────────────────────────────────────────────
  static MaterialPageRoute<dynamic> _notFoundRoute(
      RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(
            'Route "${settings.name}" tidak ditemukan.',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}