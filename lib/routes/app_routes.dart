import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/food/screens/detail_food_screen.dart';
import '../features/food/screens/detail_location_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/messages/screens/message_list_screen.dart';
import '../features/notification/screens/notification_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/elements/screens/elements_screen.dart';

class AppRoutes {
  // ── Route name constants ──────────────────────────────────────────────────
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String detailFood = '/detail-food';
  static const String detailLocation = '/detail-location';
  static const String messages = '/messages';
  static const String notification = '/notification';
  static const String profile = '/profile';
  static const String search = '/search';
  static const String elements = '/elements';

  // ── Initial route (Balik ke Onboarding/Awal) ─────────────────────────────
  static const String initialRoute = onboarding;

  // ── Route map ─────────────────────────────────────────────────────────────
  static Map<String, WidgetBuilder> get routes => {
    onboarding: (_) => const OnboardingScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    home: (_) => const HomeScreen(),
    messages: (_) => const MessageListScreen(),
    notification: (_) => const NotificationScreen(),
    profile: (_) => const ProfileScreen(),
    search: (_) => const SearchScreen(),
    elements: (_) => const ElementsScreen(),
  };

  // ── onGenerateRoute — untuk screen yang butuh arguments ───────────────────
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case detailFood:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          settings,
          DetailFoodScreen(foodId: args?['foodId'] as String? ?? ''),
        );

      case detailLocation:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          settings,
          DetailLocationScreen(
            locationId: args?['locationId'] as String? ?? '',
          ),
        );

      default:
        return _notFoundRoute(settings);
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(
    RouteSettings settings,
    Widget page,
  ) {
    return MaterialPageRoute(settings: settings, builder: (_) => page);
  }

  static MaterialPageRoute<dynamic> _notFoundRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
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
