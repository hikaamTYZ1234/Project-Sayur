import 'package:flutter/material.dart';

// AUTH
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';

// ONBOARDING (SESUAI STRUKTUR KAMU)
import '../features/screens/onboarding_screen.dart';
// MESSAGES
import '../features/messages/screens/message_list_screen.dart';
import '../features/messages/screens/chat_detail.dart';

// FOOD
import '../features/food/screens/orders_screen.dart';
import '../features/food/screens/food_detail_screen.dart';

// MAIN MENU
import '../features/main_menu/screens/color_themes_screen.dart';
import '../features/main_menu/screens/main_menu_drawer.dart';

// CORE
import '../features/home/screens/home_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/elements/screens/elements_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/notification/screens/notification_screen.dart';

class AppRoutes {
  // ONBOARDING
  static const String onboarding = '/onboarding';

  // AUTH
  static const String login = '/login';
  static const String register = '/register';

  // MESSAGES
  static const String messageList = '/message-list';
  static const String chatDetail = '/chat-detail';

  // FOOD
  static const String orders = '/orders';
  static const String foodDetail = '/food-detail';

  // MAIN MENU
  static const String colorThemes = '/color-themes';
  static const String mainMenu = '/mainmenu';

  // CORE
  static const String home = '/home';
  static const String search = '/search';
  static const String elements = '/elements';
  static const String profile = '/profile';
  static const String notification = '/notification';

  static Map<String, WidgetBuilder> get routes => {
        // 🔥 ONBOARDING PERTAMA
        onboarding: (context) => const OnboardingScreen(),

        // AUTH
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),

        // MESSAGES
        messageList: (context) => const MessageListScreen(),
        chatDetail: (context) => const ChatDetailScreen(),

        // FOOD
        orders: (context) => const OrdersScreen(),
        foodDetail: (context) => const FoodDetailScreen(),

        // MAIN MENU
        colorThemes: (context) => const ColorThemesScreen(),
        mainMenu: (context) => const MainMenuDrawer(),

        // CORE
        home: (context) => const HomeScreen(),
        search: (context) => const SearchScreen(),
        elements: (context) => const ElementsScreen(),
        profile: (context) => const ProfileScreen(),
        notification: (context) => const NotificationScreen(),
      };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (routes.containsKey(settings.name)) {
      return MaterialPageRoute(builder: routes[settings.name]!);
    }
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Halaman tidak ditemukan')),
      ),
    );
  }
}