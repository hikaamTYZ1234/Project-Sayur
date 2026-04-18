import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  // REVISI: Logika pengecekan status onboarding
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  
  // REVISI: Jika sudah pernah lihat onboarding, arahkan ke messages (bukan login)
  final initialRoute = hasSeenOnboarding ? AppRoutes.messages : AppRoutes.onboarding;

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
    // REVISI: Menggunakan Provider.of atau context.watch untuk memantau perubahan tema
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,

      initialRoute: initialRoute,  
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute, 
    );
  }
}