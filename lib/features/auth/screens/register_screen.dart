import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Logo ──────────────────────────────────────────────────
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  // ✅ Mengikuti tema: abu-abu terang (light) / abu-abu gelap (dark)
                  color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                  border: isDark
                      ? null
                      : Border.all(
                          color: AppColors.dividerLight, 
                          width: 1,
                        ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/wortel_logo.png',
                    width: 54,
                    height: 54,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.eco,
                        size: 54,
                        color: isDark ? AppColors.primaryGreenLight : AppColors.primaryGreen,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Text(
                'Start your\nhealthy life now',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 26,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // ── Name field ────────────────────────────────────────────
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Roberto Karlos',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline_rounded, 
                    color: isDark ? AppColors.iconInactiveDark : AppColors.iconInactiveLight, 
                    size: 20
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ── Email field ───────────────────────────────────────────
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.mail_outline_rounded, 
                    color: isDark ? AppColors.iconInactiveDark : AppColors.iconInactiveLight, 
                    size: 20
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ── Password field ────────────────────────────────────────
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.textHintDark : AppColors.textHintLight,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded, 
                    color: isDark ? AppColors.iconInactiveDark : AppColors.iconInactiveLight, 
                    size: 20
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: isDark ? AppColors.primaryGreenLight : AppColors.primaryGreen,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ── SIGN UP button ────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: handle register
                  },
                  child: const Text('SIGN UP'), 
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Already have an account?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),

              const SizedBox(height: 14),

              // ── LOGIN button ──────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark 
                        ? AppColors.surfaceVariantDark  
                        : AppColors.surfaceVariantLight, 
                    foregroundColor: isDark 
                        ? AppColors.textSecondaryDark 
                        : AppColors.textSecondaryLight,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: isDark 
                          ? AppColors.textSecondaryDark 
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}