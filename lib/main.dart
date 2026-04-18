import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Pastikan path import di bawah ini sesuai dengan struktur folder Anda
import 'routes/app_routes.dart'; 
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

void main() async {
  // 1. Inisialisasi binding Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inisialisasi ThemeProvider
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  // 3. Tentukan rute awal (Langsung ke Login)
  //const String initialRoute = AppRoutes.messageList;
const String initialRoute = AppRoutes.login; // REVISI: Langsung ke Login

  

  runApp(
    ChangeNotifierProvider<ThemeProvider>.value(
      value: themeProvider,
      child: const MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  
  // Constructor yang benar
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    // 4. Mengambil data theme dari Provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      // Menggunakan tema dari AppTheme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,

      // Konfigurasi Navigasi
      initialRoute: initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
