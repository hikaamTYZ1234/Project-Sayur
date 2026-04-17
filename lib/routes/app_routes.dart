import 'package:flutter/material.dart';

// Import yang sudah pasti ada (Punya kamu)
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/notification/screens/notification_screen.dart';
import '../features/elements/screens/elements_screen.dart';

// Import yang bermasalah (Saya tutup sementara agar tidak error)
// import '../features/home/screens/home_screen.dart';
// import '../features/food/screens/detail_food_screen.dart';
// import '../features/messages/screens/message_list_screen.dart';
// import '../features/search/screens/search_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String notification = '/notification';
  static const String elements = '/elements';
  static const String detailFood = '/detail-food';

  static const String initialRoute = elements;

  static Map<String, WidgetBuilder> get routes => {
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    profile: (_) => const ProfileScreen(),
    notification: (_) => const NotificationScreen(),
    elements: (_) => const ElementsScreen(),

    // Rute di bawah ini saya tutup karena class-nya error/belum ada
    // home: (_) => const HomeScreen(),
    // messages: (_) => const MessageListScreen(),
    // search: (_) => const SearchScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      /* Sementara dimatikan karena DetailFoodScreen error
      case detailFood:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Detail Food Pending'))),
        );
      */
      default:
        return _notFoundRoute(settings);
    }
  }

  static MaterialPageRoute<dynamic> _notFoundRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => Scaffold(
        body: Center(child: Text('Route "${settings.name}" belum tersedia.')),
      ),
    );
  }
}
