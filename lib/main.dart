import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ── KODE ASLI TEMANMU (Dimatikan sementara) ──────────────────────
      // initialRoute: AppRoutes.login,

      // ── KODE SEMENTARA UNTUK TESTING PROFILMU ────────────────────────
      initialRoute: AppRoutes.initialRoute,

      routes: AppRoutes.routes,
    );
  }
}
