import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      title: 'Healthy Food, For Breakfast',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    ),
    _OnboardingData(
      title: 'Start your healthy life now',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    ),
    _OnboardingData(
      title: 'Tasty & Healthy Organic Food',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
  }

  Future<void> _navigateToRegister() async {
    await _completeOnboarding();
    if (mounted) {
    Navigator.pushReplacementNamed(context, AppRoutes.messageList);
    }
  }

  Future<void> _navigateToLogin() async {
    await _completeOnboarding();
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.messageList);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final textTheme = Theme.of(context).textTheme;

    // Warna adaptif berdasarkan mode
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.primaryGreen;
    final logoBgColor = isDark ? AppColors.surfaceDark : Colors.white;
    final logoIconColor = isDark ? AppColors.primaryGreenLight : AppColors.primaryGreen;
    final textColor = isDark ? AppColors.textPrimaryDark : Colors.white;
    final subtitleColor = isDark ? AppColors.textSecondaryDark : Colors.white.withOpacity(0.85);
    final dotActiveColor = isDark ? AppColors.primaryGreenLight : Colors.white;
    final dotInactiveColor = isDark 
        ? AppColors.textHintDark.withOpacity(0.6) 
        : Colors.white.withOpacity(0.4);
    
    // Warna button adaptif
    final signUpBtnColor = isDark ? AppColors.primaryGreenLight : AppColors.accent;
    final loginBtnBgColor = isDark 
        ? AppColors.surfaceVariantDark.withOpacity(0.8) 
        : Colors.white.withOpacity(0.18);
    final loginBtnTextColor = isDark ? AppColors.textPrimaryDark : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),

            // ── Logo (Adaptif) ─────────────────────────────────────────
            _SayurLogo(
              backgroundColor: logoBgColor,
              iconColor: logoIconColor,
            ),

            const SizedBox(height: 6),

            // ── Title "Sayur" (Adaptif) ────────────────────────────────
            Text(
              'Sayur',
              style: TextStyle(
                fontFamily: 'Cursive',
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: textColor,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 4),

            // ── Subtitle (Adaptif) ─────────────────────────────────────
            Text(
              'Healthy Food Delivery',
              style: textTheme.bodyMedium?.copyWith(
                color: subtitleColor,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 20),

            // ── PageView ───────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                physics: const PageScrollPhysics(),
                itemBuilder: (context, index) {
                  return _OnboardingSlide(
                    data: _pages[index],
                    textColor: textColor,
                    subtitleColor: subtitleColor,
                    textTheme: textTheme,
                  );
                },
              ),
            ),

            // ── Dot Indicator (Adaptif) ─────────────────────────────────
            _DotIndicator(
              count: _pages.length,
              current: _currentPage,
              activeColor: dotActiveColor,
              inactiveColor: dotInactiveColor,
              onDotTap: _goToPage,
            ),

            const SizedBox(height: 20),

            // ── Buttons (Adaptif) ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // SIGN UP button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _navigateToRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: signUpBtnColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      child: const Text('SIGN UP'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // LOGIN button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: TextButton(
                      onPressed: _navigateToLogin,
                      style: TextButton.styleFrom(
                        backgroundColor: loginBtnBgColor,
                        foregroundColor: loginBtnTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      child: const Text('LOGIN'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ==================== DATA MODEL ====================
class _OnboardingData {
  final String title;
  final String description;
  const _OnboardingData({
    required this.title,
    required this.description,
  });
}

// ==================== LOGO (ADAPTIF) ====================
class _SayurLogo extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  
  const _SayurLogo({
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/wortel_logo.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Center(
            child: Icon(
              Icons.eco_rounded,
              size: 44,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== SLIDE (ADAPTIF) ====================
class _OnboardingSlide extends StatelessWidget {
  final _OnboardingData data;
  final Color textColor;
  final Color subtitleColor;
  final TextTheme textTheme;
  
  const _OnboardingSlide({
    required this.data,
    required this.textColor,
    required this.subtitleColor,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== DOT INDICATOR (ADAPTIF) ====================
class _DotIndicator extends StatelessWidget {
  final int count;
  final int current;
  final Color activeColor;
  final Color inactiveColor;
  final void Function(int) onDotTap;

  const _DotIndicator({
    required this.count,
    required this.current,
    required this.activeColor,
    required this.inactiveColor,
    required this.onDotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == current;
        return GestureDetector(
          onTap: () => onDotTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 20 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}