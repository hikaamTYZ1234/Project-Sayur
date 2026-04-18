import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';  // ← Tambahkan ini
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load tema yang tersimpan sebelumnya
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  // Cek apakah sudah pernah onboarding
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  
  // Tentukan route awal
  final initialRoute = hasSeenOnboarding ? AppRoutes.login : AppRoutes.onboarding;

  runApp(
    ChangeNotifierProvider.value(
      value: themeProvider, 
      child: MyApp(initialRoute: initialRoute),  
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  
  const MyApp({super.key, required this.initialRoute});  

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ── Theme ──────────────────────────────────────────
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,

      // ── Routes ─────────────────────────────────────────
      initialRoute: initialRoute,  
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute, 
    );
  }
}
