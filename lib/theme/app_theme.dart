import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // ════════════════════════════════════════════════
  //  LIGHT THEME
  // ════════════════════════════════════════════════
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // ── Color Scheme ──────────────────────────
      colorScheme: const ColorScheme.light(
        primary:             AppColors.primaryGreen,
        onPrimary:           Colors.white,
        primaryContainer:    AppColors.primaryBg,
        onPrimaryContainer:  AppColors.primaryGreen,

        secondary:           AppColors.accent,
        onSecondary:         Colors.white,

        // background → surface (deprecated di Material3)
        surface:             AppColors.backgroundLight,
        onSurface:           AppColors.textPrimaryLight,

        // surfaceVariant → surfaceContainerHighest (deprecated di Material3)
        surfaceContainerHighest: AppColors.surfaceVariantLight,
        onSurfaceVariant:    AppColors.textSecondaryLight,

        error:               AppColors.error,
        onError:             Colors.white,

        outline:             AppColors.dividerLight,
      ),

      // ── Scaffold ──────────────────────────────
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // ── AppBar ────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor:  AppColors.backgroundLight,
        foregroundColor:  AppColors.textPrimaryLight,
        elevation:        0,
        centerTitle:      true,
        iconTheme:        IconThemeData(color: AppColors.textPrimaryLight),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:           Colors.transparent,
          statusBarIconBrightness:  Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          color:      AppColors.textPrimaryLight,
          fontSize:   18,
          fontWeight: FontWeight.w700,
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor:      AppColors.bottomNavLight,
        selectedItemColor:    AppColors.primaryGreen,
        unselectedItemColor:  AppColors.iconInactiveLight,
        showSelectedLabels:   true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // ── Card ──────────────────────────────────
      cardTheme: CardThemeData(
        color:     AppColors.surfaceLight,
        elevation: 0,
        shape:     RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // ── Input / Search Bar ────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled:      true,
        fillColor:   AppColors.surfaceVariantLight,
        hintStyle:   const TextStyle(color: AppColors.textHintLight),
        border:      OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // ── ElevatedButton (Place Order, dll) ─────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:  AppColors.primaryGreen,
          foregroundColor:  Colors.white,
          elevation:        0,
          minimumSize:      const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize:   15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // ── OutlinedButton ────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
          side: const BorderSide(color: AppColors.primaryGreen),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      // ── Chip (Tab: All, On Delivery, Done) ────
      chipTheme: ChipThemeData(
        backgroundColor:        AppColors.surfaceVariantLight,
        selectedColor:          AppColors.backgroundLight,
        labelStyle:             const TextStyle(color: AppColors.textPrimaryLight, fontSize: 13),
        secondaryLabelStyle:    const TextStyle(color: AppColors.textPrimaryLight, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        pressElevation: 0,
      ),

      // ── Divider ───────────────────────────────
      dividerTheme: const DividerThemeData(
        color:     AppColors.dividerLight,
        thickness: 1,
        space:     1,
      ),

      // ── Icon ──────────────────────────────────
      iconTheme: const IconThemeData(color: AppColors.iconLight),

      // ── Text ──────────────────────────────────
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimaryLight),
        headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimaryLight),
        titleLarge:    TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimaryLight),
        titleMedium:   TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimaryLight),
        titleSmall:    TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimaryLight),
        bodyLarge:     TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.textPrimaryLight),
        bodyMedium:    TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textSecondaryLight),
        bodySmall:     TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textSecondaryLight),
        labelLarge:    TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimaryLight),
      ),
    );
  }

  // ════════════════════════════════════════════════
  //  DARK THEME
  // ════════════════════════════════════════════════
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // ── Color Scheme ──────────────────────────
      colorScheme: const ColorScheme.dark(
        primary:             AppColors.primaryGreenLight,
        onPrimary:           Colors.white,
        primaryContainer:    AppColors.primaryBgDark,
        onPrimaryContainer:  AppColors.primaryGreenLight,

        secondary:           AppColors.accent,
        onSecondary:         Colors.white,

        // background → surface (deprecated di Material3)
        surface:             AppColors.backgroundDark,
        onSurface:           AppColors.textPrimaryDark,

        // surfaceVariant → surfaceContainerHighest (deprecated di Material3)
        surfaceContainerHighest: AppColors.surfaceVariantDark,
        onSurfaceVariant:    AppColors.textSecondaryDark,

        error:               AppColors.error,
        onError:             Colors.white,

        outline:             AppColors.dividerDark,
      ),

      // ── Scaffold ──────────────────────────────
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // ── AppBar ────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor:  AppColors.backgroundDark,
        foregroundColor:  AppColors.textPrimaryDark,
        elevation:        0,
        centerTitle:      true,
        iconTheme:        IconThemeData(color: AppColors.textPrimaryDark),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:           Colors.transparent,
          statusBarIconBrightness:  Brightness.light,
        ),
        titleTextStyle: TextStyle(
          color:      AppColors.textPrimaryDark,
          fontSize:   18,
          fontWeight: FontWeight.w700,
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor:      AppColors.bottomNavDark,
        selectedItemColor:    AppColors.primaryGreenLight,
        unselectedItemColor:  AppColors.iconInactiveDark,
        showSelectedLabels:   true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // ── Card ──────────────────────────────────
      cardTheme: CardThemeData(
        color:     AppColors.surfaceDark,
        elevation: 0,
        shape:     RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // ── Input / Search Bar ────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled:      true,
        fillColor:   AppColors.surfaceVariantDark,
        hintStyle:   const TextStyle(color: AppColors.textHintDark),
        border:      OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryGreenLight, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // ── ElevatedButton ────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:  AppColors.primaryGreenLight,
          foregroundColor:  Colors.white,
          elevation:        0,
          minimumSize:      const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize:   15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // ── OutlinedButton ────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGreenLight,
          side: const BorderSide(color: AppColors.primaryGreenLight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      // ── Chip ──────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor:        AppColors.surfaceVariantDark,
        selectedColor:          AppColors.surfaceDark,
        labelStyle:             const TextStyle(color: AppColors.textPrimaryDark, fontSize: 13),
        secondaryLabelStyle:    const TextStyle(color: AppColors.textPrimaryDark, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        pressElevation: 0,
      ),

      // ── Divider ───────────────────────────────
      dividerTheme: const DividerThemeData(
        color:     AppColors.dividerDark,
        thickness: 1,
        space:     1,
      ),

      // ── Icon ──────────────────────────────────
      iconTheme: const IconThemeData(color: AppColors.iconDark),

      // ── Text ──────────────────────────────────
      textTheme: const TextTheme(
        headlineLarge:  TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimaryDark),
        headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimaryDark),
        titleLarge:     TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimaryDark),
        titleMedium:    TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark),
        titleSmall:     TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark),
        bodyLarge:      TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.textPrimaryDark),
        bodyMedium:     TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textSecondaryDark),
        bodySmall:      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textSecondaryDark),
        labelLarge:     TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark),
      ),
    );
  }
}