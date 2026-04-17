import 'package:flutter/material.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final Color textPrimary = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final Color textSecondary =
        isDark ? const Color(0xFF9E9E9E) : const Color(0xFF757575);
    final Color fieldFill =
        isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5);
    final Color fieldBorder =
        isDark ? const Color(0xFF3A3A3A) : const Color(0xFFE0E0E0);
    final Color iconColor =
        isDark ? const Color(0xFF9E9E9E) : const Color(0xFF9E9E9E);
    final Color logoBg =
        isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5);
    final Color createAccountBg =
        isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE);
    final Color createAccountText =
        isDark ? const Color(0xFF9E9E9E) : const Color(0xFF757575);
    const Color primaryGreen = Color(0xFF4CAF50);

    return Scaffold(
      backgroundColor: bgColor,
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
                  color: logoBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/icons/logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.eco_rounded,
                      size: 48,
                      color: primaryGreen,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Welcome back
              Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                  letterSpacing: 0.2,
                ),
              ),

              const SizedBox(height: 10),

              // Subtitle
              Text(
                'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: textSecondary,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // Email field
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'info@example.com',
                  hintStyle: TextStyle(
                    color: textSecondary,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    color: iconColor,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: fieldFill,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: fieldBorder, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: fieldBorder, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: primaryGreen, width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Password field
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: textSecondary,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: iconColor,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: primaryGreen,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: fieldFill,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: fieldBorder, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: fieldBorder, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: primaryGreen, width: 1.5),
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
                    // TODO: handle login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Or sign in with
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Or sign in with',
                    style: TextStyle(
                      fontSize: 13,
                      color: textSecondary,
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Google button
                  GestureDetector(
                    onTap: () {
                      // TODO: handle Google sign in
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: fieldFill,
                        shape: BoxShape.circle,
                        border: Border.all(color: fieldBorder, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'google.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Text(
                            'G',
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                          'facebook.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
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

              const SizedBox(height: 24),

              // Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Password? ',
                    style: TextStyle(
                      fontSize: 13,
                      color: textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: navigate to reset password
                    },
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Dont have any account
              Text(
                "Don't have any account?",
                style: TextStyle(
                  fontSize: 13,
                  color: textSecondary,
                ),
              ),

              const SizedBox(height: 14),

              // CREATE MY ACCOUNT button → navigasi ke RegisterScreen
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: createAccountBg,
                    foregroundColor: createAccountText,
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
                      color: createAccountText,
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