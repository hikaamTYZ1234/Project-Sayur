import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/messages/screens/message_list_screen.dart';
import '../features/messages/screens/chat_detail.dart';
import '../features/food/screens/orders_screen.dart';
import '../features/main_menu/screens/color_themes_screen.dart';
import '../features/main_menu/screens/main_menu_drawer.dart';
import '../features/home/screens/home_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/food/screens/food_detail_screen.dart';
import '../features/elements/screens/elements_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/notification/screens/notification_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String messageList = '/message-list';
  static const String chatDetail = '/chat-detail';
  static const String orders = '/orders';
  static const String colorThemes = '/color-themes';
  static const String mainMenu = '/mainmenu';
  static const String home = '/home';
  static const String search = '/search';
  static const String foodDetail = '/food-detail';
  static const String elements = '/elements';
  static const String profile = '/profile';
  static const String notification = '/notification';

  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    messageList: (context) => const MessageListScreen(),
    chatDetail: (context) => const ChatDetailScreen(),
    orders: (context) => const OrdersScreen(),
    colorThemes: (context) => const ColorThemesScreen(),
    mainMenu: (context) => const MainMenuDrawer(),
    home: (context) => const HomeScreen(),
    search: (context) => const SearchScreen(),
    foodDetail: (context) => const FoodDetailScreen(),
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
