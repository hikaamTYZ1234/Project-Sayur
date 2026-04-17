import 'package:flutter/material.dart';

/// Semua warna diekstrak dari desain UI "Sayur Healthy Food"
/// Light Mode & Dark Mode

class AppColors {
  AppColors._(); // tidak bisa di-instantiate

  // ─── PRIMARY (Hijau) ───────────────────────────────────────────
  static const Color primaryGreen      = Color(0xFF2E7D32); // tombol utama, icon aktif, harga
  static const Color primaryGreenLight = Color(0xFF4CAF50); // tombol Place Order dark mode
  static const Color primaryBg         = Color(0xFFE8F5E9); // background item aktif (light)
  static const Color primaryBgDark     = Color(0xFF1B3A1F); // background item aktif (dark)

  // ─── ACCENT (Oranye) ──────────────────────────────────────────
  static const Color accent            = Color(0xFFF57C00); // badge "On Delivery", tombol call

  // ─── BACKGROUND ───────────────────────────────────────────────
  static const Color backgroundLight   = Color(0xFFFFFFFF);
  static const Color backgroundDark    = Color(0xFF1A1A1A);

  // ─── SURFACE (Card, Bottom Nav, Drawer) ───────────────────────
  static const Color surfaceLight      = Color(0xFFF5F5F5);
  static const Color surfaceDark       = Color(0xFF2C2C2C);

  // ─── SURFACE VARIANT (Search bar, Tab bar) ────────────────────
  static const Color surfaceVariantLight = Color(0xFFEEEEEE);
  static const Color surfaceVariantDark  = Color(0xFF3A3A3A);

  // ─── BOTTOM NAVIGATION BAR ────────────────────────────────────
  static const Color bottomNavLight    = Color(0xFFEFEFEF);
  static const Color bottomNavDark     = Color(0xFF252525);

  // ─── TEXT ─────────────────────────────────────────────────────
  static const Color textPrimaryLight  = Color(0xFF1A1A1A);
  static const Color textPrimaryDark   = Color(0xFFFFFFFF);

  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textSecondaryDark  = Color(0xFFAAAAAA);

  static const Color textHintLight     = Color(0xFFBDBDBD);
  static const Color textHintDark      = Color(0xFF666666);

  // ─── ICON ─────────────────────────────────────────────────────
  static const Color iconLight         = Color(0xFF424242);
  static const Color iconDark          = Color(0xFFE0E0E0);

  static const Color iconInactiveLight = Color(0xFF9E9E9E);
  static const Color iconInactiveDark  = Color(0xFF757575);

  // ─── DIVIDER / BORDER ─────────────────────────────────────────
  static const Color dividerLight      = Color(0xFFE0E0E0);
  static const Color dividerDark       = Color(0xFF3D3D3D);

  // ─── PRICE TEXT (hijau) ───────────────────────────────────────
  static const Color priceGreen        = Color(0xFF2E7D32); // sama untuk keduanya

  // ─── STATUS ───────────────────────────────────────────────────
  static const Color error             = Color(0xFFD32F2F);
  static const Color success           = Color(0xFF388E3C);
  static const Color warning           = Color(0xFFF57C00);
}