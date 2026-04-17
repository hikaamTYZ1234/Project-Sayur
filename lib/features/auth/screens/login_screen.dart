import 'package:flutter/material.dart';

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
        isDark ? const Color(0xFFCCCCCC) : const Color(0xFF1A1A1A);
    final Color fieldFill =
        isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final Color fieldBorder =
        isDark ? const Color(0xFF3A3A3A) : const Color(0xFFE0E0E0);
    final Color iconColor =
        isDark ? const Color(0xFF9E9E9E) : const Color(0xFF9E9E9E);
    final Color logoBg =
        isDark ? const Color(0xFF2C2C2C) : Colors.white;
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
              // ── Logo Sayur ──────────────────────────────────────────────
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: logoBg,
                  borderRadius: BorderRadius.circular(20),
                  border: isDark
                      ? null
                      : Border.all(
                          color: const Color(0xFFE0E0E0), width: 1),
                ),
                child: const Center(
                  child: _VegetableLogo(),
                ),
              ),

              const SizedBox(height: 28),

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

              // ── Email field ─────────────────────────────────────────────
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: textPrimary, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'info@example.com',
                  hintStyle: TextStyle(
                    color: isDark
                        ? const Color(0xFF9E9E9E)
                        : const Color(0xFF1A1A1A),
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                      Icons.person_outline_rounded, color: iconColor, size: 20),
                  filled: true,
                  fillColor: fieldFill,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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

              // ── Password field ──────────────────────────────────────────
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(color: textPrimary, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                      Icons.lock_outline_rounded, color: iconColor, size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: primaryGreen,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  filled: true,
                  fillColor: fieldFill,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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

              // ── LOGIN button ────────────────────────────────────────────
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

              // ── Or sign in with ─────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Or sign in with',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? const Color(0xFFCCCCCC)
                          : const Color(0xFF1A1A1A),
                    ),
                  ),
                  Row(
                    children: [
                      // Google Logo 
                      GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white, 
                            shape: BoxShape.circle,
                            border: Border.all(color: fieldBorder, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0), 
                            child: Image.asset(
                              'assets/google_logo.png',
                              fit: BoxFit.contain, 
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.g_mobiledata,
                                  color: Colors.grey,
                                  size: 28,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Facebook Logo - DIPERBAIKI
                      GestureDetector(
                        onTap: () {
                          // TODO: Facebook sign in
                        },
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1877F2),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0), 
                            
                            child: Image.asset(
                              'assets/facebook_logo.png',
                              fit: BoxFit.contain, 
                              
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.facebook,
                                  color: Colors.white,
                                  size: 28,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Forgot Password ─────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Password? ',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? const Color(0xFFCCCCCC)
                          : const Color(0xFF1A1A1A),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: reset password
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

              Text(
                "Don't have any account?",
                style: const TextStyle(fontSize: 13, color: Color(0xFF9E9E9E)),
              ),

              const SizedBox(height: 14),

              // ── CREATE MY ACCOUNT ───────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: navigate to register
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

// LOGO SAYUR (Wortel)
class _VegetableLogo extends StatelessWidget {
  const _VegetableLogo();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(54, 54),
      painter: _CarrotPainter(),
    );
  }
}

class _CarrotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final strokePaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..style = PaintingStyle.fill;

    // Wortel kiri
    final c1 = Path()
      ..moveTo(w * 0.28, h * 0.20)
      ..cubicTo(w * 0.08, h * 0.30, w * 0.10, h * 0.62, w * 0.26, h * 0.82)
      ..cubicTo(w * 0.34, h * 0.90, w * 0.46, h * 0.82, w * 0.46, h * 0.68)
      ..cubicTo(w * 0.50, h * 0.44, w * 0.44, h * 0.26, w * 0.28, h * 0.20);
    canvas.drawPath(c1, strokePaint);

    // Daun wortel kiri
    final l1 = Path()
      ..moveTo(w * 0.28, h * 0.20)
      ..quadraticBezierTo(w * 0.16, h * 0.06, w * 0.10, h * 0.12)
      ..quadraticBezierTo(w * 0.18, h * 0.16, w * 0.28, h * 0.20);
    canvas.drawPath(l1, fillPaint);

    final l2 = Path()
      ..moveTo(w * 0.28, h * 0.20)
      ..quadraticBezierTo(w * 0.28, h * 0.02, w * 0.36, h * 0.06)
      ..quadraticBezierTo(w * 0.34, h * 0.14, w * 0.28, h * 0.20);
    canvas.drawPath(l2, fillPaint);

    final l3 = Path()
      ..moveTo(w * 0.28, h * 0.20)
      ..quadraticBezierTo(w * 0.42, h * 0.06, w * 0.48, h * 0.14)
      ..quadraticBezierTo(w * 0.40, h * 0.18, w * 0.28, h * 0.20);
    canvas.drawPath(l3, fillPaint);

    // Wortel kanan
    final c2 = Path()
      ..moveTo(w * 0.58, h * 0.24)
      ..cubicTo(w * 0.70, h * 0.28, w * 0.78, h * 0.48, w * 0.72, h * 0.68)
      ..cubicTo(w * 0.68, h * 0.78, w * 0.58, h * 0.76, w * 0.54, h * 0.64)
      ..cubicTo(w * 0.48, h * 0.46, w * 0.50, h * 0.26, w * 0.58, h * 0.24);
    canvas.drawPath(c2, strokePaint);

    // Daun wortel kanan
    final l4 = Path()
      ..moveTo(w * 0.58, h * 0.24)
      ..quadraticBezierTo(w * 0.52, h * 0.10, w * 0.58, h * 0.06)
      ..quadraticBezierTo(w * 0.62, h * 0.12, w * 0.58, h * 0.24);
    canvas.drawPath(l4, fillPaint);

    final l5 = Path()
      ..moveTo(w * 0.58, h * 0.24)
      ..quadraticBezierTo(w * 0.68, h * 0.08, w * 0.76, h * 0.14)
      ..quadraticBezierTo(w * 0.70, h * 0.20, w * 0.58, h * 0.24);
    canvas.drawPath(l5, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}