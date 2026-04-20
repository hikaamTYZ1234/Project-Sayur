import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_provider.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'wortel_logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.eco_rounded,
                      size: 48,
                      color: isDark ? AppColors.primaryGreenLight : AppColors.primaryGreen,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Welcome back 
              Text(
                'Welcome back',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Subtitle 
              Text(
                'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // Email field 
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'info@example.com',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    color: isDark ? AppColors.iconInactiveDark : AppColors.iconInactiveLight,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Password field 
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: isDark ? AppColors.iconInactiveDark : AppColors.iconInactiveLight,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: isDark ? AppColors.primaryGreenLight : AppColors.primaryGreen,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // LOGIN button 
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('LOGIN'),
                ),
              ),

              const SizedBox(height: 24),

              // Or sign in with -
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Or sign in with',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  
                  // Logo Google dan Facebook
                  Row(
                    children: [
                      // Google button
                      GestureDetector(
                        onTap: () {
                          // TODO: handle Google sign in
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark ? AppColors.dividerDark : AppColors.dividerLight, 
                              width: 1
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'google_logo.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => Text(
                                'G',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4285F4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Facebook button
                      GestureDetector(
                        onTap: () {
                          // TODO: handle Facebook sign in
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1877F2),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'facebook_logo.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.facebook,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Forgot Password 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Password? ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: navigate to reset password
                    },
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? AppColors.primaryGreenLight : AppColors.primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Don't have any account 
              Text(
                "Don't have any account?",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 14),

              // CREATE MY ACCOUNT button 
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
                    foregroundColor: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'CREATE MY ACCOUNT',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
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