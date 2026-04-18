import 'package:flutter/material.dart';
import '../features/messages/screens/message_list_screen.dart';
import '../features/screens/onboarding_screen.dart';

class AppRoutes {
  // REVISI: Nama rute disesuaikan dengan kebutuhan aktif saja
  static const String onboarding = '/onboarding';
  static const String messages = '/messages';

  // REVISI: Rute awal diarahkan ke onboarding (sesuai logika main.dart)
  static const String initialRoute = onboarding;

  static Map<String, WidgetBuilder> get routes => {
        onboarding: (_) => const OnboardingScreen(),
        messages: (_) => const MessageListScreen(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (routes.containsKey(settings.name)) {
      return MaterialPageRoute(
        settings: settings,
        builder: routes[settings.name]!,
      );
    }
    return _notFoundRoute(settings);
  }

  static MaterialPageRoute _notFoundRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const Scaffold(
        body: Center(child: Text('Halaman tidak ditemukan')),
      ),
    );
  }
}